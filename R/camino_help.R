#' @title General Camino Command Help
#' @description Wrapper for finding the manual for the Camino function
#' @param funcname Name of function to be called
#' @param ... options to pass to \code{\link{system}}
#' @return Result from system
#' @export
#'
#' @examples
#' camino_help("voxel2scanner")
camino_help = function(funcname, ...){
  man_fol = system.file(file.path("camino", "man"), package = "rcamino")
  cmd = sprintf("man -M %s %s", man_fol, funcname)
  system(cmd, ...)
}


#' @title Read Camino Command Help File
#' @description Wrapper for finding the manual for the Camino function
#' and reading it into a text file
#' @param funcname Name of function to be called
#' @return Character vector
#' @export
#'
#' @examples
#' read_camino_helpfile("voxel2scanner")
read_camino_helpfile = function(funcname){
  man_fol = system.file(file.path("camino", "man", "man1"),
                        package = "rcamino")
  funcname = paste0(funcname, ".1")
  file = file.path(man_fol, funcname)
  if (file.exists(file)) {
    res = readLines(file)
  } else {
    res = NULL
  }
  return(res)
}
