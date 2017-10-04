#' @title Wrapper for Camino \code{image2voxel} function
#' @description Performs the Camino \code{image2voxel} function
#' @param infile Input 4D image
#' @param outfile Output filename for camino format
#' @param outputdatatype Output data type
#' @param verbose Print diagnostic messages
#' @importFrom neurobase checkimg
#'
#' @export
camino_image2voxel = function(
  infile,
  outfile = NULL,
  outputdatatype = c("float", "char", "short",
                     "int", "long", "double"),
  verbose = TRUE
) {
  infile = checkimg(infile)
  outputdatatype = match.arg(outputdatatype)

  if (is.null(outfile)) {
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }

  opts = c("-inputfile" = shQuote(infile),
           "-outputfile" = shQuote(outfile),
           "-outputdatatype" = outputdatatype)
  opts = paste(names(opts), opts, collapse = " ")

  cmd = camino_cmd("image2voxel")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  if (res != 0) {
    warning("Result is non-zero, may not work")
  }
  return(outfile)
}
# -inputfile <image> | -imagelist <file> [options]

#' @rdname camino_image2voxel
#' @param imagelist Text file of list of image names or character vector
#' of image names
#' @param imageprefix Directory of the images.  Will use the dirname if
#' not specified (recommended)
#'
#' @export
camino_imagelist2voxel = function(
  imagelist,
  imageprefix = NULL,
  outfile = NULL,
  outputdatatype = c("float", "char", "short",
                     "int", "long", "double"),
  verbose = TRUE
) {

  if (!all(file.exists(imagelist))) {
    stop("Image list does not exist")
  }

  ##############################
  # Read in list of images
  ##############################
  if (length(imagelist) == 1) {
    if (verbose) {
      message("assuming imagelist is a text file of names")
    }
    imagelist = readLines(imagelist)
  }

  if (is.null(imageprefix)) {
    imageprefix = dirname(imagelist)
    imageprefix = unique(imageprefix)
  }
  if (length(imageprefix) != 1) {
    stop("imageprefix must be of length 1!")
  }
  tfile = tempfile(fileext = ".txt")
  imagelist = basename(imagelist)
  writeLines(imagelist, con = tfile)
  imagelist = tfile

  outputdatatype = match.arg(outputdatatype)

  if (is.null(outfile)) {
    outfile = tempfile(fileext = paste0(".B", outputdatatype))
  }

  opts = c("-imagelist" = shQuote(imagelist),
           "-outputfile" = shQuote(outfile),
           "-outputdatatype" = outputdatatype)
  opts = paste(names(opts), opts, collapse = " ")

  cmd = camino_cmd("image2voxel")
  cmd = paste(cmd, opts)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd)
  if (res != 0) {
    warning("Result is non-zero, may not work")
  }
  return(outfile)
}