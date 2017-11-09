#' Fit Model using Camino
#'
#' @param infile Input 4D image
#' @param bvecs The file containing the b-vectors.
#' @param bvals The file containing the b-values.
#' @param mask Provides the name of a file containing a brain / background mask.
#' The file can be raw binary or a NIFTI image.
#' Raw binary files must be big endian; the default data type is 16-bit shorts,
#'  but can be changed using the -maskdatatype option.
#'  The program does not process background voxels, but outputs the same
#'  number of values in background voxels and foreground voxels.
#'  Each value is zero in background voxels apart from the exit code which is -1.
#' @param model Type of model used: 1-tensor: dt (linear diffusion tensor, default),
#' ldt - same as dt
#' nldt_pos (nonlinear optimization, constrained to be positive semi-definite),
#' nldt     (unconstrained nonlinear optimization),
#' ldt_wtd  (weighted linear)
#' @param verbose Print diagnostic messages
#' @param inputmodel model used for tensors, passed to
#' \code{\link{camino_compute}}
#' @param ... Additional arguments passed to \code{\link{camino_fsl2scheme}}
#' or \code{\link{camino_modelfit}} or \code{\link{camino_dt2nii}}
#'
#' @return List o f
#' @export
#'
#' @examples \dontrun{
#' library(neurobase)
#' library(rcamino)
#' img = "~/Downloads/data.nii.gz"
#' bvals = "~/Downloads/bvals"
#' bvecs = "~/Downloads/bvecs"
#' mask = "~/Downloads/nodif_brain_mask.nii.gz"
#' gradadj = "~/Downloads/grad_dev.nii.gz"
#' sub = subset_dti(img = img, bvals = bvals, bvecs = bvecs,
#'                  maximum = 1500,
#' b_step = 1)
#' infile = sub$img
#' bvals = sub$bvals
#' bvecs = sub$bvecs
#' inputmodel = "dt"
#' verbose = TRUE
#' camino_dtifit(infile = infile, bvecs = bvecs, bvals = bvals, mask = mask)
#' }
camino_dtifit = function(
  infile, bvecs, bvals,
  mask,
  model = c("dt", "ldt", "nldt_pos", "nldt", "ldt_wtd", "restore"),
  verbose = TRUE,
  inputmodel = c("dt", "twotensor", "threetensor", "multitensor"),
  ...) {

  args = list(...)
  args$bvals = bvals
  args$bvecs = bvecs
  args$verbose = verbose
  args$infile = infile
  args$infile = infile
  args$model = model

  inputmodel = match.arg(inputmodel)
  args$inputmodel = inputmodel

  nargs = names(args)
  scheme_args = formalArgs(camino_fsl2scheme)
  scheme_args = args[ nargs %in% scheme_args ]

  scheme_file = do.call(camino_fsl2scheme,
                        args = scheme_args)


  args$scheme = scheme_file
  args$mask = mask

  nargs = names(args)
  model_args = formalArgs(camino_modelfit)
  model_args = args[ nargs %in% model_args ]

  mod_file = do.call(camino_modelfit,
                     args = model_args)

  fa_img = camino_fa_img(
    infile = mod_file,
    header = mask,
    inputmodel = inputmodel,
    retimg = FALSE)

  md_img = camino_md_img(
    infile = mod_file,
    header = mask,
    inputmodel = inputmodel,
    retimg = FALSE)

  tr_img = camino_trd_img(
    infile = mod_file,
    header = mask,
    inputmodel = inputmodel,
    retimg = FALSE)

  nargs = names(args)
  eig_args = formalArgs(camino_dt2nii)
  eig_args = args[ nargs %in% eig_args ]
  eig_args$infile = mod_file
  eig_args$header = mask
  if (!("outputdatatype" %in% eig_args)) {
    eig_args$outputdatatype = "double"
  }

  eig_img = do.call(camino_dt2nii,
                    args = eig_args)
  stubs = nii.stub(eig_img, bn = TRUE)
  stubs = grepl("_dt$", stubs)
  eig_img = eig_img[stubs]

  L = list(FA = fa_img,
       MD = md_img,
       TR = tr_img,
       DT = eig_img)
  return(L)

}