
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
#' @export
camino_dteig = function(infile,
                        outfile = NULL,
                        inputmodel = c("dt", "twotensor", "threetensor", "multitensor"),
                        outputdatatype = c("float", "byte", "short",
                                           "int", "long", "double"),
                        maxcomponents = NULL,
                        verbose = TRUE
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
  if (is.null(outfile)) {
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }
  outfile = shQuote(outfile)

  opts = c( "-inputfile" = infile,
            "-inputmodel" = inputmodel,
            "-outputdatatype" = outputdatatype,
            "-maxcomponents" = maxcomponents
  )
  opts = paste(names(opts), opts, collapse = " ")

  cmd = camino_cmd("dteig")
  cmd = paste(cmd, opts, " > ", outfile)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)

  #########################################
  # Construction output filenames
  #########################################
  return(outfile)
}


