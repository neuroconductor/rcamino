#' @title Wrapper for Camino \code{niftiheader} function
#' @description Performs the Camino \code{niftiheader} function
#' @export
niftiheader = function() {
  cmd = camino_cmd("niftiheader")
}
# .B niftiheader -readheader <image file> 
