\name{levelplot-methods}
\docType{methods}
\alias{levelplot,xcmsRaw-method}
\alias{levelplot,xcmsSet-method}
\title{Plot log intensity image of a xcmsRaw object}
\description{
  Create an image of the raw (profile) data m/z against retention
  time, with the intensity color coded.
}
\section{Methods}{
\describe{
\item{x = "xcmsRaw"}{
  \code{
    levelplot(x, log=TRUE, col.regions=colorRampPalette(brewer.pal(9,
    "YlOrRd"))(256), backend = c("base", "lcmsPlot"), ...)
  }
}
\item{x = "xcmsSet"}{
  \code{
    levelplot(x, log=TRUE, col.regions=colorRampPalette(brewer.pal(9,
    "YlOrRd"))(256), rt="raw", ...)
  }
}
}}
\arguments{
  \item{x}{xcmsRaw object.}
  \item{log}{Whether the intensity should be log transformed.}
  \item{col.regions}{The color ramp that should be used for encoding of
    the intensity.}
  \item{rt}{wheter the original (\code{rt="raw"}) or the corrected
    (\code{rt="corrected"}) retention times should be used.}
  \item{backend}{For the \code{xcmsRaw} method: \code{character(1)} defining
    the plotting backend. The default \code{backend = "base"} produces the
    standard \emph{lattice} levelplot. With \code{backend = "lcmsPlot"}
    the plot is generated with the (suggested) \emph{lcmsPlot} package
    (\code{lp_intensity_map()}) as a \emph{ggplot2}-based heatmap and returned
    invisibly. The m/z-on-x, retention time-on-y orientation of the lattice
    original is preserved, \code{col.regions} is honored as the fill scale and
    the region is taken from the same \code{profRange} arguments. Intensities
    are always shown on a log scale, so \code{log} is ignored. lcmsPlot draws
    the measured centroids rather than the gridded profile matrix, so the
    baseline is left blank instead of filled. Requires \emph{lcmsPlot} 1.1.8 or
    later.}
  \item{\dots}{Arguments for \code{profRange}.}
}
\author{Johannes Rainer, \email{johannes.rainer@eurac.edu}}
\seealso{
  \code{\link{xcmsRaw-class}}, \code{\link{xcmsSet-class}}
}
\keyword{hplot}

