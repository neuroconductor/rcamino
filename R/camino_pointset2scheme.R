#' @title Wrapper for Camino \code{pointset2scheme} function
#' @description Performs the Camino \code{pointset2scheme} function
#' @param infile Input gradient file
#' @param bvalue B-value multiplier
#' @param outfile Output filename for scheme file
#' @param verbose print diagnostic messages
#' @return Output filename
#' @export
camino_pointset2scheme = function(
  infile, bvalue = 1e9,
  outfile = NULL,
  verbose = TRUE) {

  scipen = getOption("scipen")
  on.exit({
    options("scipen" = scipen)
  })
  options("scipen" = 999)

  cmd = camino_cmd("pointset2scheme")
  if (is.null(outfile)) {
    outfile = tempfile(fileext = ".scheme")
  }
  infile = path.expand(infile)
  opts = c("-inputfile" = shQuote(infile),
           "-bvalue" = bvalue,
           "-outputfile" = outfile)
  opts = paste(names(opts), opts, collapse = " ")

  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  return(outfile)
}
# .B pointset2scheme  [options]
#
