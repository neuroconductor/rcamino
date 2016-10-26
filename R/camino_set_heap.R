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
  # -Xmx
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




