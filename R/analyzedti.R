#' @title Wrapper for Camino \code{analyzedti} function
#' @description Performs the Camino \code{analyzedti} function
#' @export
analyzedti = function() {
  cmd = camino_cmd("analyzedti")
}
# <4dimageroot | imagelist> <output root> <schemefile> 
# [-bgmask <file> -bgthresh <value> -inversion <value>
# -outputdatatype <type>]
