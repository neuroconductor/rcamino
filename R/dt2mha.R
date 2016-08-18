#' @title Wrapper for Camino \code{dt2mha} function
#' @description Performs the Camino \code{dt2mha} function
#' @export
dt2mha = function() {
  cmd = camino_cmd("dt2mha")
}
# dt2mha -inputfile <file> -outputroot <root> -header <header> 
