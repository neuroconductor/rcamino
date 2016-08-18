#' @title Wrapper for Camino \code{sfskewness} function
#' @description Performs the Camino \code{sfskewness} function
#' @export
sfskewness = function() {
  cmd = camino_cmd("sfskewness")
}
# .B sfskewness -inputmodel <sh|rbf|maxent>
# [options]
