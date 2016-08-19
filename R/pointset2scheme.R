#' @title Wrapper for Camino \code{pointset2scheme} function
#' @description Performs the Camino \code{pointset2scheme} function
#' @export
pointset2scheme = function(infile, bvalue = NULL,
                           outfile = NULL) {

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
  res = system(cmd)
}
# .B pointset2scheme  [options]
#
