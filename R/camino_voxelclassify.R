#' @title Wrapper for Camino \code{voxelclassify} function
#' @description Performs the Camino \code{voxelclassify} function
#'
#' @param infile input filename
#' @param scheme Scheme file
#' @param outfile output filename
#' @param outputdatatype Specifies the data type of the output image, only
#' relevant if \code{outfile} is not specified
#' The data type can be any of the following strings:
#' "byte", "short", "int", "long", "float" or "double".
#' @param mask Character or \code{nifti} to mask out background.
#' @param bgthresh background threshold value.  If \code{mask} is specified,
#' this is overridden.  Ignored  if \code{ftest} is not specified.
#' @param csfthresh CSF threshold value
#' @param order Set the maximum even spherical harmonic order
#' that will be considered by the program.
#' Must be a positive even number. Default is 4.
#' @param ftest Specifies  the  F-test thresholds for adopting higher order models. A threshold must be provided for every order between 0  and
#' the maximum order. The program will not consider a higher order
#' model unless the result of the F-test is smaller than the
#' relevant threshold.
#' @param verbose Print diagnostic messages
#'
#' @export
camino_voxelclassify = function(infile,
                                scheme,
                                outfile = NULL,
                                outputdatatype = NULL,
                                mask = NULL,
                                bgthresh = NULL,
                                csfthresh = NULL,
                                order = 4,
                                ftest = NULL,
                                verbose = TRUE) {
  infile = checkimg(infile)
  scipen = getOption("scipen")
  on.exit({
    options("scipen" = scipen)
  })
  options("scipen" = 999)


  if (!is.null(mask)) {
    mask = checkimg(mask)
    if (!is.null(bgthresh)) {
      warning("mask was specified, overriding bgthresh")
      bgthresh = NULL
    }
  }

  if (is.null(outfile)) {
    outputdatatype = "double"
    if (is.null(ftest)) {
      outputdatatype = "int"
    }
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }

  if (!is.null(ftest)) {
    ftest = paste0(ftest, collapse = " ")
  }
  if (length(order) > 0) {
    if ( !(order %% 2 == 0) ) {
      stop("order must be an even number")
    }
  }
  opts = c("-inputfile" = infile,
          "-schemefile" = scheme,
          "-bgmask" = mask,
          "-bgthresh" = bgthresh,
          "-csfthresh" = csfthresh,
          "-order" = order,
          "-ftest" = ftest
          )
  opts = collapse_opts(opts)

  cmd = camino_cmd("voxelclassify")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  cmd = paste0(cmd, " > ", outfile)
  res = system(cmd)

  return(outfile)
}
# .B voxelclassify
# [-bgthresh <value>] [-csfthresh <maxA0>] [-order <maxOrder>]  [-ftest <thresholds>]
