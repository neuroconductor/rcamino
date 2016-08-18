#' @title Wrapper for Camino \code{pdview} function
#' @description Performs the Camino \code{pdview} function
#' @export
pdview = function() {
  cmd = camino_cmd("pdview")
}
# -inputmodel <dteig (default) | pds | pico | ballstick> -datadims <x> <y>
# <z> [-scalarthresh <threshold>] [-scalarrange <min> <max>]
# [-scalarfile <file>] -norgb -maxcomponents <max tensors per voxel> | -numpds
# <max peaks per voxel>
