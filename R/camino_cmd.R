#' @title General Camino Command Maker
#' @description Wrapper for finding the path for the Camino function
#' @param funcname Name of function to be called
#' @return Character vector of length 1
#' @export
#'
#' @examples
#' camino_cmd("voxel2scanner")
camino_cmd = function(funcname){
  system.file(file.path("camino", "bin", funcname), package = "rcamino")
}
