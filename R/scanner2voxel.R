#' @title Wrapper for Camino \code{scanner2voxel} function
#' @description Performs the Camino \code{scanner2voxel} function
#' @export
scanner2voxel = function() {
  cmd = camino_cmd("scanner2voxel")
}
# -voxels <number of voxels> -components <measurements per voxel> [options]
