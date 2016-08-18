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

x = sapply(binaries, function(funcname) {
  camino_help(funcname, intern = TRUE)
})


makefunc = function(funcname, write = FALSE, remove = FALSE) {
  cat("#", funcname, fill = TRUE)
  x = readLines("camino_generic_function.R")
  x = gsub("%%", funcname, x)
  x = gsub("%type", type, x)
  if (! is.null(ex_text)) {
    ex_text[1] = paste0("@examples ", ex_text[1])
    ex_text = paste0("#' ", ex_text)
    ex_text = paste0(ex_text, collapse= "\n")
    x = gsub("%example%", ex_text, x, fixed = TRUE)
  } else {
    x = gsub("%example%", "#'", x)
  }
  if (write) {
    writeLines(text = x, con = paste0("R/", f_no_dot, ".R"))
  }
  if (remove) {
    file.remove(paste0("R/", f_no_dot, ".R"))
  }
  invisible()
}
