#' @title Wrapper for Camino \code{selectshells} function
#' @description Performs the Camino \code{selectshells} function
#'
#' @param infile Input 4D file to select shells
#' @param schemefile Scheme file with gradient information
#' @param max_bval Maximum b-value to include in the output. Default infinity
#' (include all b-values). In the same units as the scheme file.
#' @param min_bval Minimum b-value to include in the output.
#' Default 0. In the same units as the scheme file.
#' b=0 measurements are treated as a special case and are not removed unless
#' the \code{remove_zero} is \code{TRUE}.
#' @param output_root Root of output files, selected shells of
#' DWI data are output along with the associated scheme file.
#' Output file format will be the same as the input (NIFTI or raw).
#' @param verbose Print diagnostic messages
#' @param remove_zero If \code{TRUE}, b=0 measurements are not selected.
#' By default they are selected even if a minimum b-value is specified.
#' @param max_unweighted_bval Maximum b-value to include as an unweighted
#' measurement. Some imaging schemes have a small non-zero b-value
#' for the unweighted measurements. With this option, any b-value
#' less than or equal to the specified value are treated as b=0.
#' @return Output filename
#'
#' @export
camino_selectshells = function(
  infile,
  schemefile,
  max_bval = NULL,
  min_bval = NULL,
  output_root = tempfile(),
  max_unweighted_bval = NULL,
  remove_zero = FALSE,
  verbose = TRUE
) {
  # unweightedb = max_unweighted_bval
  # removezeromeas = remove_zero
  # minbval = min_bval
  # maxbval = max_bval
  # schemefile = schemefile
  # infile = infile
  # outputroot = output_root

  if (!file.exists(schemefile)) {
    stop("Scheme file does not exist!")
  }

  infile = checkimg(infile)

  low_file = tolower(infile)
  ext = tools::file_ext(low_file)
  img_ext = neurobase::parse_img_ext(infile)
  if (ext == "gz") {
    img_ext = paste0(img_ext, ext)
  }


  make_num = function(x) {
    if (!is.null(x)) {
      x = as.numeric(x)
    }
    return(x)
  }
  max_bval = make_num(max_bval)
  min_bval = make_num(min_bval)
  max_unweighted_bval = make_num(max_unweighted_bval)

  remove_zero = as.logical(remove_zero)

  names(schemefile) = names(infile) = NULL
  names(max_bval) = NULL
  names(min_bval) = NULL
  names(output_root) = NULL
  names(max_unweighted_bval) = NULL
  names(remove_zero) = NULL

  opts = c(
    "-inputfile" = infile,
    "-schemefile" = schemefile,
    "-maxbval" = max_bval,
    "-minbval" = min_bval,
    "-unweightedb" = max_unweighted_bval,
    "-outputroot" = output_root
  )

  log_opts = c("-removezeromeas" = remove_zero)
  log_opts = collapse_log_opts(log_opts)
  opts = collapse_opts(opts)
  opts = paste(opts, log_opts)

  cmd = camino_cmd("selectshells")
  cmd = paste(cmd, opts)

  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  if (res != 0) {
    warning("Result is non-zero, may not work")
  }
  outfile = file.path(output_root, img_ext)
  return(outfile)
}



