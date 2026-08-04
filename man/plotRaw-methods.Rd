\name{plotRaw-methods}
\docType{methods}
%\alias{plotRaw-methods}
\alias{plotRaw}
\alias{plotRaw,xcmsRaw-method}
\title{Scatterplot of raw data points}
\description{
  Produce a scatterplot showing raw data point location in retention
  time and m/z. This plot is more useful for centroided data than
  continuum data.
}
\section{Methods}{
\describe{
\item{object = "xcmsRaw"}{
  \code{plotRaw(object, mzrange = numeric(), rtrange = numeric(),
                scanrange = numeric(), log=FALSE, title='Raw Data',
                backend = c("base", "lcmsPlot"))}
}
}}
\arguments{
  \item{object}{the \code{xcmsRaw} object}
  \item{mzrange}{
    numeric vector of length >= 2 whose range will be used to select
    the masses to plot
  }
  \item{rtrange}{
    numeric vector of length >= 2 whose range will be used to select
    the retention times to plot
  }
  \item{scanrange}{
    numeric vector of length >= 2 whose range will be used to select
    scans to plot
  }
  \item{log}{
    logical, log transform intensity
  }
  \item{title}{
    main title of the plot
  }
  \item{backend}{\code{character(1)} defining the plotting backend. The
    default \code{backend = "base"} draws the classical raw-data scatter.
    With \code{backend = "lcmsPlot"} the plot is generated with the
    (suggested) \emph{lcmsPlot} package
    (\code{lp_intensity_map(geom = "point")}), which draws the same scatter of
    individual centroids as a \emph{ggplot2} figure and returns the plot object
    invisibly. \code{log}, \code{title} and \code{scanrange} are ignored on the
    lcmsPlot branch, and intensity is always mapped on a log scale. Requires
    \emph{lcmsPlot} 1.1.8 or later.}
}
\value{
  A matrix with the points plotted.
}
\seealso{
  \code{\link{xcmsRaw-class}}
}
\keyword{methods}
\keyword{hplot}
