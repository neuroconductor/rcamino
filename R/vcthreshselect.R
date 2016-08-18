#' @title Wrapper for Camino \code{vcthreshselect} function
#' @description Performs the Camino \code{vcthreshselect} function
#' @export
vcthreshselect = function() {
  cmd = camino_cmd("vcthreshselect")
}
# -datadims <x> <y> <z> -order <order> [-bgthresh <value>
# -csfthresh <value> -ftest <f1 f1 f3>]
