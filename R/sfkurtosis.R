#' @title Wrapper for Camino \code{sfkurtosis} function
#' @description Performs the Camino \code{sfkurtosis} function
#' @export
sfkurtosis = function() {
  cmd = camino_cmd("sfkurtosis")
}
# .B sfkurtosis -inputmodel <sh|rbf|maxent>
# [options]
