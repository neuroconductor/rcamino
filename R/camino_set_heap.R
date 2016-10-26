#' @title Set Camino Heap Size
#' @description Set Camino Heap Size to Increase Memory
#' @param heap_size Heap size (in MB) for camino command
#' @return NULL
#' @export
#'
#' @examples
#' camino_set_heap(heap_size = 4000)
camino_set_heap = function(heap_size = 4000){
  # options("CAMINO_HEAP_SIZE" = heap_size)
  Sys.setenv("CAMINO_HEAP_SIZE" = heap_size)
  java_max = paste0("-Xmx", heap_size, "m")
  j_opts = Sys.getenv("_JAVA_OPTIONS")
  ss = strsplit(j_opts, " ")[[1]]
  ind = grepl("-Xmx", ss)
  if (any(ind)) {
    ss[ind] = java_max
  }
  ss = paste(ss, collapse = " ")
  Sys.setenv("_JAVA_OPTIONS" = ss)
  return(invisible(NULL))
}

#' @title Get Camino Heap Size
#' @description Get Camino Heap Size
#' @param heap_size Heap size (in MB) if \code{CAMINO_HEAP_SIZE} is not set
#' @return Numeric Value
#' @export
#'
#' @examples
#' camino_get_heap()
camino_get_heap = function(heap_size = 4000){
  heap = Sys.getenv("CAMINO_HEAP_SIZE")
  if (is.null(heap)) {
    heap = heap_size
    camino_set_heap(heap_size)
  }
  if (heap == "") {
    heap = heap_size
    camino_set_heap(heap_size)
  }
  heap = as.numeric(heap)
  if (is.na(heap)) {
    heap = heap_size
    camino_set_heap(heap_size)
  }
  return(heap)
}




