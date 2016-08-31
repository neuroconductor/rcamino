#' @title Wrapper for Camino \code{dt2nii} function
#' @description Performs the Camino \code{dt2nii} function
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param header NIfTI image with header information
#' @param inputmodel model used for tensors
#' @param outputroot Output file root. If there is one component, or output is to a vector,
#' the output image is called root.ext, otherwise output is numbered by component.
#' @param outputdatatype Specifies the data type of the output image.
#' The data type can be any of the following strings:
#' "byte", "short", "int", "long", "float" or "double".
#' @param maxcomponents Maximum tensor components, for use with input model "multitensor".
#' @param gzip Set gzip compression for the output image, if supported by the image format.
#' @param verbose print diagnostic messages
#' @export
camino_dt2nii = function(infile,
                         header,
                         inputmodel = c("dt", "twotensor", "threetensor", "multitensor"),
                         outputroot = NULL,
                         outputdatatype = NULL,
                         maxcomponents = NULL,
                         gzip = TRUE,
                         verbose = TRUE
) {

  infile = checkimg(infile)
  header = checkimg(header)
  inputmodel = match.arg(inputmodel)
  if (inputmodel != "multitensor") {
    maxcomponents = NULL
  } else {
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
            "-inputmodel" = inputmodel,
            "-outputroot" = outputroot,
            "-outputdatatype" = outputdatatype,
            "-maxcomponents" = maxcomponents
  )
  ext = ".nii"
  if (gzip) {
    opts = c(opts, "-gzip" = "")
    ext = ".nii.gz"
  }
  opts = collapse_opts(opts)

  cmd = camino_cmd("dt2nii")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)

  #########################################
  # Construction output filenames
  #########################################
  out_suff = c("exitcode", "lns0")

  if (inputmodel == "dt") {
    out_suff = c(out_suff, "dt")
  } else {
    n_comp = switch(inputmodel,
                    "twotensor" = 2,
                    "threetensor" = 3,
                    "multitensor" = maxcomponents)
    add_suffs = c(sapply(seq_along(n_comp), function(x){
      paste0(c("dt", "mix"), x)
    }))
    out_suff = c(out_suff, add_suffs)
  }
  outfiles = paste0(outputroot, out_suff, ext)

  return(outfiles)
}
# .B voxel2image  -outputroot <root> -header <header> -components <N> [options]
