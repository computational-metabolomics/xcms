\name{plotScan-methods}
\docType{methods}
%\alias{plotScan-methods}
\alias{plotScan}
\alias{plotScan,xcmsRaw-method}
\title{Plot a single mass scan}
\description{
  Plot a single mass scan using the impulse representation. Most
  useful for centroided data.
}
\section{Methods}{
\describe{
\item{object = "xcmsRaw"}{
  \code{plotScan(object, scan, mzrange = numeric(), ident = FALSE,
                 backend = c("base", "lcmsPlot"))}
}
}}
\arguments{
  \item{object}{the \code{xcmsRaw} object}
  \item{scan}{
    integer with number of scan to plot
  }
  \item{mzrange}{
    numeric vector of length >= 2 whose range will be used to select
    masses to plot
  }
  \item{ident}{
    logical, use mouse to interactively identify and label individual
    masses
  }
  \item{backend}{\code{character(1)} defining the plotting backend. The
    default \code{backend = "base"} uses base R graphics. With
    \code{backend = "lcmsPlot"} the plot is generated with the (suggested)
    \emph{lcmsPlot} package (\code{lp_spectra(scan_index = scan)}) and the
    \emph{ggplot2}-based plot object is returned invisibly. \code{mzrange}
    and \code{ident} are ignored on the lcmsPlot branch, which also does not
    warn about an out-of-range \code{scan}.}
}
\seealso{
  \code{\link{xcmsRaw-class}}
}
\keyword{methods}
\keyword{hplot}
