#' @title Wrapper for Camino \code{imagestats} function
#' @description Performs the Camino \code{imagestats} function
#' @export
imagestats = function() {
  cmd = camino_cmd("imagestats")
}
# .B imagestats -stat <stat> -outputroot <root> -images <image1 image2 ... >
