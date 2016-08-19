#' @title Wrapper for Camino \code{datastats} function
#' @description Performs the Camino \code{datastats} function
#' @export
datastats = function() {
  cmd = camino_cmd("datastats")
}
# [-schemefile <filename> -bgmask <filename>]
