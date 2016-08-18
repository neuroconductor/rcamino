#' @title Wrapper for Camino \code{selectshells} function
#' @description Performs the Camino \code{selectshells} function
#' @export
selectshells = function() {
  cmd = camino_cmd("selectshells")
}
# .B selectshells 
# -inputfile <data> -schemefile <scheme> -maxbval <max>
# -outputroot <root> [options]
