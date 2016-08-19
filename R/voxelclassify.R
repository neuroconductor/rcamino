#' @title Wrapper for Camino \code{voxelclassify} function
#' @description Performs the Camino \code{voxelclassify} function
#' @export
voxelclassify = function() {
  cmd = camino_cmd("voxelclassify")
}
# .B voxelclassify 
# [-bgthresh <value>] [-csfthresh <maxA0>] [-order <maxOrder>]  [-ftest <thresholds>]
