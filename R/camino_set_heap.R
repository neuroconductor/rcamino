#' @title Set Camino Heap Size
#' @description Set Camino Heap Size to Increase Memory
#' @param heap_size Heap size (in MB) for camino command
#' @return NULL
#' @export
#'
#' @examples
#' camino_set_heap(heap_size = 4000)
camino_set_heap = function(heap_size = 4000){
  options("CAMINO_HEAP_SIZE" = heap_size)
  Sys.setenv("CAMINO_HEAP_SIZE" = heap_size)
  return(invisible(NULL))
}


