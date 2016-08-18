#' @title Wrapper for Camino \code{dtlutgen} function
#' @description Performs the Camino \code{dtlutgen} function
#' @export
dtlutgen = function() {
  cmd = camino_cmd("dtlutgen")
}
# .B dtlutgen 
# -[l|f]range <min> <max> -step <step> -snr <value> -schemefile
# <file> [options]
