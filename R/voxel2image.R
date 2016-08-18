#' @title Wrapper for Camino \code{voxel2image} function
#' @description Performs the Camino \code{voxel2image} function
#' @export
voxel2image = function() {
  cmd = camino_cmd("voxel2image")
}
# .B voxel2image  -outputroot <root> -header <header> -components <N> [options]
