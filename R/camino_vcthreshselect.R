#' @title Wrapper for Camino \code{vcthreshselect} function
#' @description Performs the Camino \code{vcthreshselect} function
#'
#' @param infile input filename
#' @param datadims data dimensions in voxels.  Must be a vector of
#' length 3.
#' @param bgthresh background threshold value.
#' Ignored  if \code{ftest} is not specified.
#' @param csfthresh CSF threshold value
#' @param order Set the maximum even spherical harmonic order
#' that will be considered by the program.
#' Must be a positive even number. Default is 4.
#' @param ftest Specifies  the  F-test thresholds for adopting higher order models. A threshold must be provided for every order between 0  and
#' the maximum order. The program will not consider a higher order
#' model unless the result of the F-test is smaller than the
#' relevant threshold.
#' @export
camino_vcthreshselect = function(infile,
                                 datadims,
                                 bgthresh = NULL,
                                 csfthresh = NULL,
                                 order = 4,
                                 ftest = NULL,
                                 verbose = TRUE) {

  infile = checkimg(infile)
  stopifnot(length(datadims) == 3)
  scipen = getOption("scipen")
  on.exit({
    options("scipen" = scipen)
  })
  options("scipen" = 999)

  if (!is.null(ftest)) {
    ftest = paste0(ftest, collapse = " ")
  }

  datadims = paste0(datadims, collapse = " ")

  if (length(order) > 0) {
    if ( !(order %% 2 == 0) ) {
      stop("order must be an even number")
    }
  }
  opts = c("-inputfile" = infile,
           "-datadims" = datadims,
           "-bgthresh" = bgthresh,
           "-csfthresh" = csfthresh,
           "-order" = order,
           "-ftest" = ftest
  )
  opts = collapse_opts(opts)

  cmd = camino_cmd("vcthreshselect")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  return(res)
}
# -datadims <x> <y> <z> -order <order> [-bgthresh <value>
# -csfthresh <value> -ftest <f1 f1 f3>]

