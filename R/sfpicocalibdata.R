#' @title Wrapper for Camino \code{sfpicocalibdata} function
#' @description Performs the Camino \code{sfpicocalibdata} function
#' @export
sfpicocalibdata = function() {
  cmd = camino_cmd("sfpicocalibdata")
}
# .B sfpicocalibdata -snr <S> -schemefile  <Scheme file name> -infooutputfile  <information output filename> 
# [options]
