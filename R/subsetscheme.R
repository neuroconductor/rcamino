#' @title Wrapper for Camino \code{subsetscheme} function
#' @description Performs the Camino \code{subsetscheme} function
#' @export
subsetscheme = function() {
  cmd = camino_cmd("subsetscheme")
}
# .B subsetscheme -schemefile  <file> -subsetpoints <points> 
# -outputroot <root> [-imagelist <list>]
#  
