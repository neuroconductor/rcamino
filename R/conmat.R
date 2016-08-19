#' @title Wrapper for Camino \code{conmat} function
#' @description Performs the Camino \code{conmat} function
#' @export
conmat = function() {
  cmd = camino_cmd("conmat")
}
# .B conmat -targetfile <file> -outputroot <root> [options]
