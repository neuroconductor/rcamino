#' @title Wrapper for Camino \code{voxel2scanner} function
#' @description Performs the Camino \code{voxel2scanner} function
#' @export
voxel2scanner = function() {
  cmd = camino_cmd("voxel2scanner")
}
# -voxels <number of voxels> -components <measurements per voxel> [options]
