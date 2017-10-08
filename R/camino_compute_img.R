#' @title Wrapper for Computing Outputs into image
#' @description Wraps around \code{\link{camino_compute}} and
#' \code{\link{camino_voxel2image}} to compute the output then make it
#' back into an image
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param header NIfTI image for header information to pass to
#' \code{\link{camino_voxel2image}}
#' @param retimg Should an image be returned?  This will
#' be read in using \code{\link{readnii}}
#' @param ... additional arguments to pass to \code{\link{camino_compute}}
#'
#' @export
#' @importFrom neurobase readnii
camino_compute_img = function(
  infile,
  header,
  retimg = TRUE,
  ...) {

  tmp = camino_compute(
    infile = infile,
    ...)
  img = camino_voxel2image(
    infile = tmp,
    header = header)
  if (retimg) {
    img = neurobase::readnii(img)
  }
  return(img)
}

#' @title Compute Fractional Anisotropy (FA) Maps
#' @description Performs the Camino \code{fa} function to compute
#' Fractional Anisotropy maps
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param header NIfTI image for header information to pass to
#' \code{\link{camino_voxel2image}}
#' @param ... additional arguments to pass to \code{\link{camino_compute}}
#' @export
camino_fa_img = function(
  infile,
  header,
  ...) {
  camino_compute_img(infile = infile,
                 header = header,
                 cmd = "fa", ...)
}

#' @title Compute Mean Diffusivity (MD) Maps
#' @description Performs the Camino \code{md} function to compute
#' Mean Diffusivity maps
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param header NIfTI image for header information to pass to
#' \code{\link{camino_voxel2image}}
#' @param ... additional arguments to pass to \code{\link{camino_compute}}
#' @export
camino_md_img = function(
  infile,
  header,
  ...) {
  camino_compute_img(infile = infile,
                     header = header,
                     cmd = "md", ...)
}


#' @title Compute Tensor Trace Maps
#' @description Performs the Camino \code{trd} function to compute
#' Tensor Trace maps
#' @param infile Output from \code{\link{camino_modelfit}}
#' @param header NIfTI image for header information to pass to
#' \code{\link{camino_voxel2image}}
#' @param ... additional arguments to pass to \code{\link{camino_compute}}
#' @export
camino_trd_img = function(
  infile,
  header,
  ...) {
  camino_compute_img(infile = infile,
                     header = header,
                     cmd = "trd", ...)
}
