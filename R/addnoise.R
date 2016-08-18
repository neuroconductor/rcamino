#' @title Wrapper for Camino \code{addnoise} function
#' @description Performs the Camino \code{addnoise} function
#' @export
addnoise = function() {
  cmd = camino_cmd("addnoise")
}
# .B addnoise -sigma <noise std> [-noisetype <type>]
