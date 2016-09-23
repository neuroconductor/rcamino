#' @title Wrapper for Camino \code{image2voxel} function
#' @description Performs the Camino \code{image2voxel} function
#' @param infile Input 4D image
#' @param outfile Output filename for camino format
#' @param outputdatatype Output data type
#' @param verbose Print diagnostic messages
#' @importFrom neurobase checkimg
#'
#' @export
camino_image2voxel = function(infile,
                              outfile = NULL,
                              outputdatatype = c("float", "char", "short",
                                                 "int", "long", "double"),
                              verbose = TRUE
) {
  infile = checkimg(infile)
  outputdatatype = match.arg(outputdatatype)

  if (is.null(outfile)) {
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }

  opts = c("-inputfile" = shQuote(infile),
           "-outputfile" = shQuote(outfile),
           "-outputdatatype" = outputdatatype)
  opts = paste(names(opts), opts, collapse = " ")

  cmd = camino_cmd("image2voxel")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  return(outfile)
}
# -inputfile <image> | -imagelist <file> [options]
