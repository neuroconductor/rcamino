#' @title Wrapper for Camino \code{float2txt} function
#' @description Performs the Camino \code{float2txt} function
#' @export
float2txt = function() {
  cmd = camino_cmd("float2txt")
}
# .B float2txt  [decimal_places] [-linenum] [-components <N>]
