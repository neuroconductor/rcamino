#' @title Wrapper for Camino \code{dtfit} function
#' @description Performs the Camino \code{dtfit} function
#' @export
dtfit = function() {
  cmd = camino_cmd("dtfit")
}
# <data file> <scheme file> [-nonlinear] [options]
