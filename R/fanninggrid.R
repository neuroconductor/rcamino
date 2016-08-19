#' @title Wrapper for Camino \code{fanninggrid} function
#' @description Performs the Camino \code{fanninggrid} function
#' @export
fanninggrid = function() {
  cmd = camino_cmd("fanninggrid")
}
# .B fanninggrid -diffusivity <number> -volfrac <number> -gridsize <x y z> -centredist <number> -outputfile <filename>
