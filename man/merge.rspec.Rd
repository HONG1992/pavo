\name{merge.rspec}
\alias{merge.rspec}
\title{Merge two rspec objects}
\usage{
  merge.rspec(x, y, by = "wl", ...)
}
\arguments{
  \item{x,y}{(required) two data frames (or \code{rspec}
  objects) to merge}

  \item{...}{additional class arguments}
}
\value{
  an object of class \code{rspec} for use with \code{pavo}
  functions
}
\description{
  Merges two \code{rspec} or \code{data.frame} objects into
  a single \code{rspec} object
}
\examples{
\dontrun{

# Load and split dataset into 2 sections
data(teal)
teal1 <- teal[, c(1, 3:5)]
teal2 <- teal[, c(1, 2, 6:12)]
teal.mer <- merge(teal1, teal2, by='wl')
head(teal.mer)
par(mfrow=c(1, 2))
plot(teal.mer)
plot(teal)
}
}
\author{
  Chad Eliason \email{cme16@zips.uakron.edu}
}
