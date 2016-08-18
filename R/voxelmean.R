#' @title Wrapper for Camino \code{voxelmean} function
#' @description Performs the Camino \code{voxelmean} function
#' @export
voxelmean = function() {
  cmd = camino_cmd("voxelmean")
}
# .B voxelmean -voxelelements <int N> [-inputdatatype <float|double> -inputfile <filename>]
