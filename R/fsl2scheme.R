#' @title Wrapper for Camino \code{fsl2scheme} function
#' @description Performs the Camino \code{fsl2scheme} function
#' @export
fsl2scheme = function() {
  cmd = camino_cmd("fsl2scheme")
}
# .B fsl2scheme 
# -bvecfile <bvecs> -bvalfile <bvals> -diffusiontime
# <secs>
#  -bscale <factor> [-flipx] [-flipy] [-flipz] [-usegradmod]
