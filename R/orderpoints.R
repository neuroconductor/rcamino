#' @title Wrapper for Camino \code{orderpoints} function
#' @description Performs the Camino \code{orderpoints} function
#' @export
orderpoints = function() {
  cmd = camino_cmd("orderpoints")
}
# .B orderpoints  [-options]
# -inputfile <file> | -numpoints <number> -seed <seed> -temperature <initial temp>
# -coolingfactor <epsilon> -trialsbetweencooling <trials> [-savestate <root>]
#  
