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
#' @return List of values and such
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
#' args = list()
#' camino_set_heap(heap_size = 10000)
#' res = camino_dtifit(infile = infile, bvecs = bvecs,
#' bvals = bvals, mask = mask, model = "dt", inputmodel = "dt")
#' }
#' @importFrom neurobase nii.stub
#' @importFrom methods formalArgs
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

  model = match.arg(model)
  args$model = model

  inputmodel = match.arg(inputmodel)
  args$inputmodel = inputmodel

  nargs = names(args)
  scheme_args = formalArgs(camino_fsl2scheme)
  scheme_args = args[ nargs %in% scheme_args ]
  # let's do temp for everything
  scheme_args$outfile = NULL

  if (verbose) {
    message("Making scheme")
  }
  scheme_file = do.call(camino_fsl2scheme,
                        args = scheme_args)


  args$scheme = scheme_file
  args$mask = mask

  if (verbose) {
    message("Fitting Model")
  }
  nargs = names(args)
  model_args = formalArgs(camino_modelfit)
  model_args = args[ nargs %in% model_args ]
  # let's do temp for everything
  model_args$outfile = NULL

  mod_file = do.call(
    camino_modelfit,
    args = model_args)

  if (verbose) {
    message("Calculating FA/MD/TRD maps")
  }
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

  if (verbose) {
    message("Calculating Diffusion Tensor (DT)")
  }
  #################################
  # Calculate DT
  #################################
  nargs = names(args)
  dt_args = formalArgs(camino_dt2nii)
  dt_args = args[ nargs %in% dt_args ]
  dt_args$infile = mod_file
  dt_args$header = mask
  dt_args$outputroot = NULL

  if (!("outputdatatype" %in% dt_args)) {
    dt_args$outputdatatype = "double"
  }
  dt_img = do.call(
    camino_dt2nii,
    args = dt_args)
  stubs = neurobase::nii.stub(dt_img, bn = TRUE)
  stubs = sub(".*_", "", stubs)
  names(dt_img) = stubs
  dt_img = as.list(dt_img)

  if (verbose) {
    message("Extracting Eigenvalues and Eigenvectors")
  }
  #################################
  # Let's get this system of eigenvalues
  #################################
  nargs = names(args)
  eig_args = formalArgs(camino_dteig)
  eig_args = args[ nargs %in% eig_args ]
  eig_args$infile = mod_file
  eig_args$header = mask
  eig_args$outfile = NULL

  eig_img = do.call(
    camino_dteig,
    args = eig_args)

  if (verbose) {
    message("Extracting Eigenvalues and Eigenvectors")
  }
  eig_img = camino_split4dnii(eig_img)
  ord = c("val_1", paste0("vec_1_", 1:3),
          "val_2", paste0("vec_2_", 1:3),
          "val_3", paste0("vec_3_", 1:3))
  ord = rep(ord, length = length(eig_img))
  names(eig_img) = ord
  eig_img = as.list(eig_img)



  L = list(
    model = mod_file,
    scheme = scheme_file,
    inputmodel = inputmodel,
    model = model,
    FA = fa_img,
    MD = md_img,
    TR = tr_img)
  L = c(L, eig_img)
  L = c(L, dt_img)

  return(L)

}