binaries = c("adcfit", "addnoise", "analyze2voxel", "analyzedti", "analyzeheader",
  "averagedwi", "axialdistfit", "ballstickfit", "byte2txt", "cbsmat",
  "char2txt", "chunkstats", "combinetwofibreluts", "conmat", "consfrac",
  "countseeds", "counttracts", "datastats", "datasynth", "double2txt",
  "dt2mha", "dt2nii", "dteig", "dtfit", "dtlutgen", "dtmx", "dtpdview",
  "dtshape", "estimatesnr", "fa", "fanninggrid", "float2txt", "fsl2scheme",
  "gatherstats", "image2voxel", "imagessd", "imagestats", "int2txt",
  "invstats", "linrecon", "long2txt", "mask", "mbalign", "md",
  "mesd", "mfrstats", "mha2dt", "modelfit", "multitenfit", "niftiheader",
  "nii2dt", "orderpoints", "orientbiasmap", "pdview", "picopdfs",
  "pointset2scheme", "procstreamlines", "qballmx", "reorient",
  "restore", "rgbscalarimg", "scan", "scanner2voxel", "scheme2fsl",
  "selectshells", "sfanis", "sfkurtosis", "sflutgen", "sfpeaks",
  "sfpicocalibdata", "sfplot", "sfskewness", "shfit", "shformatconverter",
  "short2txt", "shredder", "split4dnii", "subsetpoints", "subsetscheme",
  "targetprobs2txt", "threetenfit", "track", "tractshredder", "tractstatimage",
  "tractstats", "trd", "twotenfit", "vcthreshselect", "voxel2image",
  "voxel2scanner", "voxelclassify", "voxelmean", "vtkstreamlines",
  "wdtfit")

x = lapply(binaries, function(funcname) {
  print(funcname)
  parse_camino_args(funcname)
})
names(x) = binaries

makefunc = function(funcname, write = TRUE, remove = FALSE) {
  cat("#", funcname, fill = TRUE)
  x = readLines("camino_generic_function.R")
  x = gsub("%%", funcname, x)
  args = parse_camino_args(funcname)
  args = paste0("# ", args)
  x = c(x, args)

  fname = paste0("R/", funcname, ".R")
  if (write) {
    writeLines(text = x, con = fname)
  }
  if (remove) {
    file.remove(fname)
  }
  invisible()
}
sapply(binaries, makefunc, write = FALSE, remove = TRUE)