#' @title Wrapper for Camino \code{fsl2scheme} function
#' @description Performs the Camino \code{fsl2scheme} function
#'
#' @param bvecs The file containing the b-vectors.
#' @param bvals The file containing the b-values.
#' @param bscale Scaling  factor  to  convert  the b-values into different units.
#' Default is 10^6.
#' @param flipx Negate the x component of all the vectors.
#' @param flipy Negate the y component of all the vectors.
#' @param flipz Negate the z component of all the vectors.
#' @param interleave Interleave repeated scans.
#' Only used with \code{-numscans}. If this  is
#' selected,  the output will be interleaved, so you will have mea-
#' surement 0 repeated numScans times, then measurement 1, etc.
#' @param zerobval   Set an effective zero b-value, input b-values less than or equal
#' to  this  are set to zero in the output. This is needed for some
#' Camino programs that normalize the input data by  dividing  each
#' measurement by the mean b=0 measurement. This  value is tested after any applicable scaling is applied to
#' the bvals.
#' @param numscans Output all measurements number times, used when combining multiple  scans  from the same imaging session. The default behaviour
#' is to repeat the entire block of measurements,  like  you'd  get
#' from copying and pasting the scheme number times. If -interleave
#' is specified, then identical measurements are grouped  together.
#' @param usegradmod Use the gradient magnitude to scale b.
#' This option has no effect if your gradient directions have unit magnitude.
#' It should  only be  used  if your scanner does not normalize the
#' gradient directions.
#' @export
camino_fsl2scheme = function(
  bvecs,
  bvals,
  outfile = NULL,
  diffusiontime = NULL,
  bscale = NULL,
  flipx = FALSE,
  flipy = FALSE,
  flipz = FALSE,
  interleave = FALSE,
  zerobval = NULL,
  numscans = NULL,
  usegradmod = FALSE
) {


  if (is.null(outfile)) {
    outfile = tempfile(fileext = ".scheme")
  }
  if (is.matrix(bvecs)) {
    stopifnot(ncol(bvecs) == 3)
    tfile = tempfile(fileext = ".txt")
    bvecs = apply(bvecs, 1, paste, collapse = " ")
    writeLines(bvecs, con = tfile)
    bvecs = tfile
  }

  if (is.numeric(bvals)) {
    tfile = tempfile(fileext = ".txt")
    bvals = as.character(bvals)
    writeLines(bvals, con = tfile)
    bvals = tfile
  }

  opts = c(
    "-diffusiontime" = diffusiontime,
    "-bscale" = bscale,
    "-zerobval" = zerobval,
    "-numscans" = numscans
  )
  log_opts = c("-flipx" = flipx,
               "-flipy" = flipy,
               "-flipz" = flipz,
               "-usegradmod" = usegradmod,
               "-interleave" = interleave)
  log_opts = collapse_log_opts(log_opts)
  opts = paste(opts, log_opts)

  cmd = camino_cmd("fsl2scheme")
  cmd = paste(cmd, opts, " > ", outfile)

  return(outfile)
}
# .B fsl2scheme
# -bvecfile <bvecs> -bvalfile <bvals> -diffusiontime
# <secs>
#  -bscale <factor> [-flipx] [-flipy] [-flipz] [-usegradmod]
# interleave zerobval numscans usegradmod
