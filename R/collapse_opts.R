#' @title Collapse Options
#' @description Simple wrapper to collapse options into a string for Camino
#' @param opts Options to be passed, where the names of the options are the
#' Camino options
#'
#' @return String
#' @export
collapse_opts = function(opts) {
  opts = paste(names(opts), opts, collapse = " ")
}

#' @title Collapse Logical Options
#' @description Simple wrapper to collapse options into a string for Camino
#' @param opts Options to be passed, where the names of the options are the
#' Camino options
#'
#' @return String
#' @export
collapse_log_opts = function(opts) {
  n = names(opts)
  opts = as.logical(opts)
  n = n[ opts ]
  if (length(n) > 0) {
    opts = paste(n, collapse = " ")
  } else {
    opts = ""
  }
  return(opts)
}