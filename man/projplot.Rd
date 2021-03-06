% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/projplot.R, R/projpoints.R
\name{projplot}
\alias{projplot}
\alias{projpoints}
\title{Hue projection plot}
\usage{
projplot(tcsdata, ...)

projpoints(tcsres, ...)
}
\arguments{
\item{tcsdata}{(required) color space coordinates, possibly a result from the \code{\link{tcs}} function,
containing values for the 'h.theta' and 'h.phi' coordinates as columns (labeled as such).}

\item{...}{additional parameters to be passed to the plotting of data points.}

\item{tcsres}{(required) color space coordinates, possibly a result from the \code{\link{tcs}} function,
containing values for the 'h.theta' and 'h.phi' coordinates as columns (labeled as such).}
}
\value{
\code{projplot} creates a 2D plot  of color points projected from the tetrahedron
to its encapsulating sphere, and is ideal to visualize differences in hue.

\code{projpoints} creates points in a projection color space plot
produced by \code{projplot}.
}
\description{
Produces a 2D projection plot of points in a color space

Adds points to a tetrahedral colorspace projection
}
\note{
\code{projplot} uses the Mollweide projection, and not the Robinson projection, which
has been used in the past. Among other advantages, the Mollweide projection preserves area
relationships within latitudes without distortion.
}
\examples{
\dontrun{
data(sicalis)
vis.sicalis <- vismodel(sicalis, visual = 'avg.uv')
tcs.sicalis <- colspace(vis.sicalis, space = 'tcs')
projplot(tcs.sicalis, pch = 16, col = setNames(rep(1:3, 7), rep(c('C', 'T', 'B'), 7)))
}

}
\references{
Stoddard, M. C., & Prum, R. O. (2008). Evolution of avian plumage
 color in a tetrahedral color space: A phylogenetic analysis of new world buntings.
 The American Naturalist, 171(6), 755-776.

Endler, J. A., Westcott, D., Madden, J., & Robson, T. (2005). Animal
 visual systems and the evolution of color patterns: Sensory processing illuminates
 signal evolution. Evolution, 59(8), 1795-1818.
}
\author{
Rafael Maia \email{rm72@zips.uakron.edu}
}
