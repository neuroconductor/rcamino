#' @title Wrapper for Camino \code{split4dnii} split4dnii
#' @description Performs the Camino \code{selectshells} function
#'
#' @param infile Input 4D file to split
#' @param schemefile Scheme file with gradient information (optional).
#' Will output CSV not returned by this function
#' @param output_root Root of output files
#' Output file format will be the same as the input (NIFTI or raw).
#' @param verbose Print diagnostic messages
#'
#' @export
#' @return Output filenames
#' @importFrom neurobase parse_img_ext
#' @importFrom tools file_ext
camino_split4dnii = function(
  infile,
  output_root = tempfile(fileext = "_"),
  schemefile = NULL,
  verbose = TRUE
) {


  if (!is.null(schemefile)) {
    if (!file.exists(schemefile)) {
      stop("Scheme file does not exist!")
    }
  }

  infile = checkimg(infile)

  low_file = tolower(infile)
  ext = tools::file_ext(low_file)
  img_ext = neurobase::parse_img_ext(infile)
  if (ext == "gz") {
    img_ext = paste0(img_ext, ".", ext)
  }

  opts = c(
    "-inputfile" = infile,
    "-schemefile" = schemefile,
    "-outputroot" = output_root
  )

  opts = collapse_opts(opts)

  cmd = camino_cmd("split4dnii")
  cmd = paste(cmd, opts)

  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  if (res != 0) {
    warning("Result is non-zero, may not work")
  }
  outfiles = list.files(
    pattern = paste0(basename(output_root), ".*", img_ext),
    path = dirname(output_root),
    full.names = TRUE,
    recursive = FALSE)
  return(outfiles)
}
