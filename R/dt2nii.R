#' @title Wrapper for Camino \code{dt2nii} function
#' @description Performs the Camino \code{dt2nii} function
#' @export
dt2nii = function() {
  cmd = camino_cmd("dt2nii")
}
# dt2nii -inputfile <file> -outputroot <root> -header <header> 
