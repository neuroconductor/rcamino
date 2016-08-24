#' @title Wrapper for Camino \code{voxel2image} function
#' @description Performs the Camino \code{voxel2image} function
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param header NIfTI image with header information
#' @param outputroot Output file root. If there is one component, or output is to a vector,
#' the output image is called root.ext, otherwise output is numbered by component.
#' @param inputdatatype specify input data type, options are
#' "byte", "short", "int", "long", "float" or "double"
#' @param components The number of components in the input data. The default is 1.
#' @param gzip Set gzip compression for the output image, if supported by the image format.
#' @param outputdatatype Specifies the data type of the output image.
#' The data type can be any of the following strings:
#' "byte", "short", "int", "long", "float" or "double".
#' @param outputvector Output multi-component voxels to a single image.
#' @param verbose print diagnostic messages
#' @export
camino_voxel2image = function(infile,
                              header,
                              outputroot = NULL,
                              inputdatatype = NULL,
                              outputdatatype = NULL,
                              components = 1,
                              gzip = TRUE,
                              outputvector = FALSE,
                              verbose = TRUE
) {

  infile = checkimg(infile)
  header = checkimg(header)

  #########################
  # Fixing types
  #########################
  if (!is.null(inputdatatype)) {
    inputdatatype = match.arg(inputdatatype,
                              choices = c("float", "byte", "short",
                                          "int", "long", "double"))
  }
  if (!is.null(outputdatatype)) {
    outputdatatype = match.arg(outputdatatype,
                               choices = c("float", "byte", "short",
                                           "int", "long", "double"))
  }
  if (is.null(outputroot)) {
    outputroot = tempfile(fileext = "_")
  }

  opts = c( "-inputfile" = infile,
            "-header" = header,
            "-outputroot" = outputroot,
            "-inputdatatype" = inputdatatype,
            "-outputdatatype" = outputdatatype,
            "-components" = components
  )
  ext = ".nii"
  if (gzip) {
    opts = c(opts, "-gzip" = "")
    ext = ".nii.gz"
  }
  if (outputvector) {
    opts = c(opts, "-outputvector" = "")
  }
  opts = paste(names(opts), opts, collapse = " ")

  cmd = camino_cmd("voxel2image")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  if (components == 1) {
    outfile = paste0(outputroot, ext)
  } else {
    outfile = paste0(outputroot, seq(components), ext)
  }
  return(outfile)

}
# .B voxel2image  -outputroot <root> -header <header> -components <N> [options]
