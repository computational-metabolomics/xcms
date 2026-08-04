\name{plotTIC-methods}
\docType{methods}
%\alias{plotTIC-methods}
\alias{plotTIC}
\alias{plotTIC,xcmsRaw-method}
\title{Plot total ion count}
\description{
  Plot chromatogram of total ion count. Optionally allow identification
  of target peaks and viewing/identification of individual spectra.
}
\section{Methods}{
\describe{
\item{object = "xcmsRaw"}{
  \code{plotTIC(object, ident = FALSE, msident = FALSE,
                backend = c("base", "lcmsPlot"))}
}
}}
\arguments{
  \item{object}{the \code{xcmsRaw} object}
  \item{ident}{
    logical, use mouse to identify and label chromatographic peaks
  }
  \item{msident}{
    logical, use mouse to identify and label spectral peaks
  }
  \item{backend}{\code{character(1)} defining the plotting backend. The
    default \code{backend = "base"} uses base R graphics. With
    \code{backend = "lcmsPlot"} the plot is generated with the (suggested)
    \emph{lcmsPlot} package (\code{lp_chromatogram(aggregation_fun = "sum")})
    and the \emph{ggplot2}-based plot object is returned invisibly.
    \code{ident} and \code{msident} are ignored on the lcmsPlot branch.}
}
\value{
  If \code{ident == TRUE}, an integer vector with the indecies of
  the points that were identified. Otherwise a two-column matrix
  with the plotted points.
}
\seealso{
  \code{\link{xcmsRaw-class}}
}
\keyword{methods}
\keyword{hplot}
\keyword{iplot}
