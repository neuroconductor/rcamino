#' @title Wrapper for Camino \code{cbsmat} function
#' @description Performs the Camino \code{cbsmat} function
#' @export
cbsmat = function() {
  cmd = camino_cmd("cbsmat")
}
# .B cbsmat -seedfile <file> -targetfile <file> -outputroot <root>  [options]
