#' @title Wrapper for Camino \code{targetprobs2txt} function
#' @description Performs the Camino \code{targetprobs2txt} function
#' @export
targetprobs2txt = function() {
  cmd = camino_cmd("targetprobs2txt")
}
# .B targetprobs2txt  -inputroot <root> -seedfile <file> -targetfile <file> 
# -pd <pd> -regionindex <index> -outputfile <file>
