\name{plotChrom-methods}
\docType{methods}
%\alias{plotChrom-methods}
\alias{plotChrom}
\alias{plotChrom,xcmsRaw-method}
\title{Plot extracted ion chromatograms from the profile matrix}
\description{
  Uses the pre-generated profile mode matrix to plot averaged or
  base peak extracted ion chromatograms over a specified mass range.
}
\section{Methods}{
\describe{
\item{object = "xcmsRaw"}{
  \code{plotChrom(object, base = FALSE, ident = FALSE,
                  fitgauss = FALSE, vline = numeric(0),
                  backend = c("base", "lcmsPlot"), ...)}
}
}}
\arguments{
  \item{object}{the \code{xcmsRaw} object}
  \item{base}{logical, plot a base-peak chromatogram}
  \item{ident}{logical, use mouse to identify and label peaks}
  \item{fitgauss}{logical, fit a gaussian to the largest peak}
  \item{vline}{numeric vector with locations of vertical lines}
  \item{backend}{\code{character(1)} defining the plotting backend. The
    default \code{backend = "base"} uses base R graphics. With
    \code{backend = "lcmsPlot"} the plot is generated with the (suggested)
    \emph{lcmsPlot} package and returned invisibly. \code{base} selects the
    aggregation: \code{base = TRUE} maps onto
    \code{lp_chromatogram(aggregation_fun = "max")} (base peak chromatogram)
    and \code{base = FALSE} onto \code{aggregation_fun = "mean"} (averaged ion
    chromatogram). The mean is taken over the profile matrix, so it matches the
    base-graphics trace for objects read with a non-zero \code{profstep}.
    \code{ident}, \code{fitgauss} and \code{vline} are ignored on the lcmsPlot
    branch. Requires \emph{lcmsPlot} 1.1.8 or later.}
  \item{...}{arguments passed to \code{\link{profRange}}}
}
\value{
  If \code{ident == TRUE}, an integer vector with the indecies of
  the points that were identified. If \code{fitgauss == TRUE}, a
  \code{nls} model with the fitted gaussian. Otherwise a two-column
  matrix with the plotted points.
}
\seealso{
  \code{\link{xcmsRaw-class}}
}
\keyword{methods}
\keyword{hplot}
\keyword{iplot}
