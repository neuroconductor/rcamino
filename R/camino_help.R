#' @title General Camino Command Help
#' @description Wrapper for finding the manual for the Camino function
#' @param funcname Name of function to be called
#' @param ... options to pass to \code{\link{system}}
#' @return Result from system
#' @export
#'
#' @examples
#' camino_help("voxel2scanner")
camino_help = function(funcname, ...){
  man_fol = system.file(file.path("camino", "man"), package = "caminor")
  cmd = sprintf("man -M %s %s", man_fol, funcname)
  system(cmd, ...)
}
