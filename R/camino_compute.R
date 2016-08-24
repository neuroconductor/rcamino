#' @title Wrapper for Computing FA/MD and other Standard Markers
#' @description Performs the Camino \code{fa} and \code{md} functions to
#' compute mean diffusivity (MD) and fractional anisotropy (FA) markers
#' @param cmd Command to perform
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param inputmodel model used for tensors
#' @param outfile Output filename for FA map
#' @param inputdatatype specify input data type, options are
#' float, char, short, int, long, double
#' @param outputdatatype output data type
#' @param verbose print diagnostic messages
#' @export
camino_compute = function(
  cmd = c("fa", "md", "trd"),
  infile,
  inputmodel = c("dt", "twotensor", "threetensor", "multitensor"),
  outfile = NULL,
  inputdatatype = NULL,
  outputdatatype = c("double", "float", "char", "short",
                     "int", "long"),
  verbose = TRUE) {

  cmd = match.arg(cmd)
  infile = checkimg(infile)

  if (!is.null(inputdatatype)) {
    inputdatatype = match.arg(inputdatatype,
                              c("float", "char", "short",
                                "int", "long", "double"))
  }
  outputdatatype = match.arg(outputdatatype)
  if (is.null(outfile)) {
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }
  inputmodel = match.arg(inputmodel)

  opts = c( "-inputmodel" = inputmodel,
            "-inputdatatype" = inputdatatype,
            "-outputdatatype" = outputdatatype
  )
  opts = paste(names(opts), opts, collapse = " ")
  opts = paste0(opts, " > ", shQuote(outfile))

  cmd = camino_cmd("fa")
  start = paste0("cat ", shQuote(infile), " | ")
  cmd = paste(start,  cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  return(outfile)
}


#' @title Compute Fractional Anisotropy (FA) Maps
#' @description Performs the Camino \code{fa} function to compute
#' Fractional Anisotropy maps
#' @param ... Arguments to pass to \code{\link{camino_compute}}
#' @export
camino_fa = function(...) {
  camino_compute(cmd = "fa", ...)
}

#' @title Compute Mean Diffusivity (MD) Maps
#' @description Performs the Camino \code{md} function to compute
#' Mean Diffusivity maps
#' @param ... Arguments to pass to \code{\link{camino_compute}}
#' @export
camino_md = function(...) {
  camino_compute(cmd = "md", ...)
}


#' @title Compute Tensor Trace Maps
#' @description Performs the Camino \code{trd} function to compute
#' Tensor Trace maps
#' @param ... Arguments to pass to \code{\link{camino_compute}}
#' @export
camino_trd = function(...) {
  camino_compute(cmd = "trd", ...)
}