#' @title Wrapper for Camino \code{nii2dt} function
#' @description Performs the Camino \code{nii2dt} function
#' @export
nii2dt = function() {
  cmd = camino_cmd("nii2dt")
}
# .B nii2dt -inputfile [image.nii] [-s0 <file> | -lns0 <file>] [options]
