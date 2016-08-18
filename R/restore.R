#' @title Wrapper for Camino \code{restore} function
#' @description Performs the Camino \code{restore} function
#' @export
restore = function() {
  cmd = camino_cmd("restore")
}
# <data file> <scheme file> <noise std> [<outlier map file>] [options]
