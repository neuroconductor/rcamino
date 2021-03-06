% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/camino_compute_img.R
\name{camino_compute_img}
\alias{camino_compute_img}
\title{Wrapper for Computing Outputs into image}
\usage{
camino_compute_img(infile, header, retimg = TRUE, ...)
}
\arguments{
\item{infile}{Output from \code{\link{camino_modelfit}}}

\item{header}{NIfTI image for header information to pass to
\code{\link{camino_voxel2image}}}

\item{retimg}{Should an image be returned?  This will
be read in using \code{\link{readnii}}}

\item{...}{additional arguments to pass to \code{\link{camino_compute}}}
}
\description{
Wraps around \code{\link{camino_compute}} and
\code{\link{camino_voxel2image}} to compute the output then make it
back into an image
}
