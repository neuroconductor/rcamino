#' @title Wrapper for Camino \code{axialdistfit} function
#' @description Performs the Camino \code{axialdistfit} function
#' @export
axialdistfit = function() {
  cmd = camino_cmd("axialdistfit")
}
# .B axialdistfit -pdf <pdftype> [-outputpicoformat] [-evecs
# <theta_1 phi_1 theta_2 phi_2 theta_3 phi_3>] 
# [-vectorspervoxel <num>] [-bgmask <mask>]
