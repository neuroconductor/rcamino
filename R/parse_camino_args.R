#' @title Parse arguments from Camino
#' @description Wrapper for finding the arguments for the Camino function
#' @param funcname Name of function to be called
#' @return Character vector
#' @export
#'
#' @examples
#' read_camino_helpfile("voxel2scanner")
parse_camino_args = function(funcname){
  vec = read_camino_helpfile(funcname)
  ind1 = grep(".SH SYNOPSIS", vec, fixed = TRUE)
  ind2 = grep(".SH DESCRIPTION", vec, fixed = TRUE)
  vec = vec[seq(ind1 + 1, ind2 - 1)]
  vec = vec[ vec != "" ]
  return(vec)
}