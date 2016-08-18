#' @title Wrapper for Camino \code{estimatesnr} function
#' @description Performs the Camino \code{estimatesnr} function
#' @export
estimatesnr = function() {
  cmd = camino_cmd("estimatesnr")
}
# estimatesnr -bgmask <mask> -schemefile <file>
# [-noiseroi <roi>]
