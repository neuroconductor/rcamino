#' @title Wrapper for Camino \code{dtpdview} function
#' @description Performs the Camino \code{dtpdview} function
#' @export
dtpdview = function() {
  cmd = camino_cmd("dtpdview")
}
# -datadims <x> <y> <z> [-fathresh <threshold>] -maxcomponents
# <max tensors per voxel>
