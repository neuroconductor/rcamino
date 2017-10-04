#' Subset Maximum B-value
#'
#' @param infile Input 4D image
#' @param schemefile Scheme file with b-values and b-vectors
#' @param max_bval Maximum b-value to include in the output. Default infinity
#' (include all b-values). In the same units as the scheme file.
#' @param verbose Print diagnostic messages
#'
#' @return List of output filename and output scheme file
#' @export
camino_subset_max_bval = function(
  infile,
  schemefile,
  max_bval = NULL,
  verbose = TRUE) {

  if (is.null(max_bval)) {
    stop("Maximum bvalue must be greater than zero")
  }

  scheme_df = utils::read.fwf(schemefile,
                              widths = rep(12, 4),
                              header = FALSE,
                              skip = 2)
  # drop last row
  scheme_df = scheme_df[ -nrow(scheme_df),]

  if (any(is.na(scheme_df))) {
    stop("Missing values in scheme file!")
  }
  keep_files = scheme_df$V4 < max_bval

  scheme_data = readLines(schemefile)
  n_bvals = length(scheme_data)
  if (scheme_data[n_bvals] != "") {
    stop("last row of shcheme file is not missing")
  }
  # skip first 2 rows and last row is empty
  ind = seq(3, n_bvals - 1)
  n_files = length(keep_files)

  stopifnot(n_files == length(ind))
  ind = ind[keep_files]
  ind = c(1, 2, ind, n_bvals)

  scheme_data = scheme_data[ind]
  new_scheme_file = tempfile(fileext = ".scheme")
  writeLines(scheme_data, con = new_scheme_file)

  infile = checkimg(infile)
  sub_4d_files = camino_split4dnii(
    infile = infile,
    verbose = verbose)

  stopifnot(length(sub_4d_files) == n_files)
  sub_4d_files = sub_4d_files[keep_files]

  imagelist = sub_4d_files

  output_voxelfile = camino_imagelist2voxel(
    imagelist = imagelist,
    verbose = verbose)

  L = list(image = output_voxelfile,
           scheme = new_scheme_file)

  return(L)
}