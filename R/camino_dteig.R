
#' @title Wrapper for Camino \code{dteig} function
#' @description Performs the Camino \code{dteig} function
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param outfile Output filename.  If \code{NULL}, a temporary filename will be make
#' @param inputmodel model used for tensors
#' @param outputdatatype Specifies the data type of the output image.
#' The data type can be any of the following strings:
#' "byte", "short", "int", "long", "float" or "double".
#' @param maxcomponents Maximum tensor components, for use with input model "multitensor".
#' @param verbose print diagnostic messages
#' @param header NIfTI image with header information
#' @export
camino_dteig = function(
  infile,
  outfile = NULL,
  inputmodel = c("dt", "twotensor", "threetensor", "multitensor"),
  outputdatatype = c("float", "byte", "short",
                     "int", "long", "double"),
  maxcomponents = NULL,
  verbose = TRUE,
  header = NULL
) {

  infile = checkimg(infile)
  inputmodel = match.arg(inputmodel)

  ########################################
  # Fixing up maxcomponents
  ########################################
  if (inputmodel == "twotensor") {
    inputmodel = "multitensor"
    if (is.null(maxcomponents)) {
      maxcomponents = 2
    }
  }
  if (inputmodel == "threetensor") {
    inputmodel = "multitensor"
    if (is.null(maxcomponents)) {
      maxcomponents = 3
    }
  }

  if (inputmodel == "multitensor") {
    if (is.null(maxcomponents)) {
      stop('If inputmodel = "multitensor", maxcomponents must be specified!')
    } else {
      if (maxcomponents < 1) {
        stop('If inputmodel = "multitensor", maxcomponents must be > 0')
      }
    }
  }


  #########################
  # Fixing types
  #########################
  outputdatatype = match.arg(outputdatatype)

  if (!is.null(header)) {
    header = checkimg(header)
    ext = ".nii.gz"
  } else {
    ext = paste0(".B", outputdatatype)
  }

  if (is.null(outfile)) {
    outfile = tempfile(fileext = ext)
  }
  xoutfile = outfile
  outfile = shQuote(outfile)

  infile = unname(infile)
  inputmodel = unname(inputmodel)
  outputdatatype = unname(outputdatatype)
  maxcomponents = unname(maxcomponents)

  opts = c( "-inputfile" = infile,
            "-inputmodel" = inputmodel,
            "-outputdatatype" = outputdatatype,
            "-maxcomponents" = maxcomponents
  )

    # can use nifti if header in there
  if (!is.null(header)) {
     header = unname(header)
     opts = c(opts, "-header" = header)
  }
  opts = paste(names(opts), opts, collapse = " ")


  # don't need stdout if header in there
  if (!is.null(header)) {
    ending = "-outputfile"
  } else {
    ending = " > "
  }

  cmd = camino_cmd("dteig")
  cmd = paste(cmd, opts, ending, outfile)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  if (res != 0) {
    warning("Result is non-zero, may not work")
  }
  if (!file.exists(xoutfile)) {
    warning("Output file does not exist, may be error!")
  }
  #########################################
  # Construction output filenames
  #########################################
  return(xoutfile)
}


