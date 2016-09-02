#' @title Wrapper for Camino \code{adcfit} function
#' @description Performs the Camino \code{adcfit} function
#'
#' @param infile input filename
#' @param scheme scheme file for b-values/b-vectors
#' @param outfile Output filename
#' @param outputdatatype Output data type
#' @param verbose Print diagnostic messages
#' @export
camino_adcfit = function(infile,
                         scheme,
                         outfile = NULL,
                         outputdatatype = c("double", "float",
                                            "byte", "short",
                                                      "int", "long"),
                         verbose = TRUE) {
  outputdatatype = match.arg(outputdatatype)

  if (is.null(outfile)) {
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }
  opts = c(infile, scheme)
  opts = paste0(opts, collapse = " ")

  cmd = camino_cmd("adcfit")
  cmd = paste(cmd, opts, " > ", outfile)

  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  return(outfile)
}
# <data file> <scheme file>
