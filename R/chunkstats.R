#' @title Wrapper for Camino \code{chunkstats} function
#' @description Performs the Camino \code{chunkstats} function
#' @export
chunkstats = function() {
  cmd = camino_cmd("chunkstats")
}
# .B chunkstats -chunksize <num. values per chunk> -samples <number of chunks per voxel> <-max|-mean|-min|-std> [options]
# For each <number of samples>, chunkstats outputs the specified statistics of <number of
# samples> chunks of chunksize values, which by default are assumed to be eight-byte
# doubles.
