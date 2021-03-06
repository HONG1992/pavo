% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/segspace.R
\name{segspace}
\alias{segspace}
\title{Segment classification}
\usage{
segspace(vismodeldata)
}
\arguments{
\item{vismodeldata}{(required) quantum catch color data. Can be either the result
from \code{\link{vismodel}} or independently calculated data (in the form of a data frame
with columns named 'S1', 'S2', 'S3', 'S4', and, optionally, 'lum', representing a generic
'tetrachromatic' viewer).}
}
\value{
A data frame of class \code{colspace} consisting of the following columns:

\code{S1}, \code{S2}, \code{S3}, \code{S4}: the relative reflectance at each
of the four segments.

\code{LM}, \code{MS}: segment scores

\code{C}, \code{H}, \code{B}: 'chroma', 'hue' (degrees), and 'brightness' in the segment classification space
}
\description{
Calculates segment classification measures as defined in Endler (1990).
}
\examples{
\dontrun{
data(sicalis)
vis.sic <- vismodel(sicalis, visual = 'segment', achromatic = 'all')
seg.sic <- colspace(vis.sic, space = 'segment')
}

}
\references{
Endler, J. A. (1990) On the measurement and classification of
color in studies of animal color patterns. Biological Journal of the Linnean
Society, 41, 315-352.
}
\author{
Thomas White \email{thomas.white026@gmail.com}

Pierre-Paul Bitton \email{bittonp@uwindsor.ca}
}
\keyword{internal}
