#' @title Wrapper for Camino \code{wdtfit} function
#' @description Performs the Camino \code{wdtfit} function
#' @export
wdtfit = function() {
  cmd = camino_cmd("wdtfit")
}
# <data file> <scheme file> [noise var map file] [options]
