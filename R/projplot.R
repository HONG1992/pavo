#' Hue projection plot
#'
#' Produces a 2D projection plot of points in a color space
#'
#' @param tcsdata (required) color space coordinates, possibly a result from the \code{\link{tcs}} function,
#' containing values for the 'h.theta' and 'h.phi' coordinates as columns (labeled as such).
#' @param ... additional parameters to be passed to the plotting of data points.
#'
#' @return \code{projplot} creates a 2D plot  of color points projected from the tetrahedron
#' to its encapsulating sphere, and is ideal to visualize differences in hue.
#' @note \code{projplot} uses the Mollweide projection, and not the Robinson projection, which
#' has been used in the past. Among other advantages, the Mollweide projection preserves area
#' relationships within latitudes without distortion.
#'
#' @export
#'
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#'
#' @examples \dontrun{
#' data(sicalis)
#' vis.sicalis <- vismodel(sicalis, visual = 'avg.uv')
#' tcs.sicalis <- colspace(vis.sicalis, space = 'tcs')
#' projplot(tcs.sicalis, pch = 16, col = setNames(rep(1:3, 7), rep(c('C', 'T', 'B'), 7)))
#' }
#'
#' @references Stoddard, M. C., & Prum, R. O. (2008). Evolution of avian plumage
#'  color in a tetrahedral color space: A phylogenetic analysis of new world buntings.
#'  The American Naturalist, 171(6), 755-776.
#' @references Endler, J. A., Westcott, D., Madden, J., & Robson, T. (2005). Animal
#'  visual systems and the evolution of color patterns: Sensory processing illuminates
#'  signal evolution. Evolution, 59(8), 1795-1818.

projplot <- function(tcsdata, ...) {

  # Check for mapproj
  if (!requireNamespace("mapproj", quietly = TRUE)) {
    stop("Package \"mapproj\" needed for projection plots. Please install it.",
         call. = FALSE)
  }
  
  # oPar <- par(no.readonly=TRUE)
  oPar <- par("mar")
  on.exit(par(oPar))

  points.theta <- tcsdata[, "h.theta"]
  points.phi <- tcsdata[, "h.phi"]

  n <- length(points.theta)

  # Edges of the tetrahedron, adjusted
  vert.theta <- c(-3.1415, 3.1415, -1.047198, 1.047198, -2.617994)
  vert.phi <- c(-0.3398369, -0.3398369, -0.3398369, -0.3398369, 1.5707963)

  # Edges of the figure
  edge.theta <- c(-pi, -pi, pi, pi)
  edge.phi <- c(-pi / 2, pi / 2, -pi / 2, pi / 2)

  # adjust points

  points.theta <- ifelse(points.theta >= -0.5235988,
    points.theta - (150 / 180 * pi),
    points.theta + (210 / 180 * pi)
  )


  # radians to degrees
  coords.theta <- c(edge.theta, vert.theta, points.theta) * 180 / pi
  coords.phi <- c(edge.phi, vert.phi, points.phi) * 180 / pi

  # map projection coordinates

  mp <- mapproj::mapproject(coords.theta, coords.phi, projection = "mollweide")

  mp.v.theta <- mp$x[1:9]
  mp.v.phi <- mp$y[1:9]

  mp.p.theta <- mp$x[-c(1:9)]
  mp.p.phi <- mp$y[-c(1:9)]

  # plot

  cu <- t(col2rgb("#984EA3")) / 255
  cs <- t(col2rgb("#377EB8")) / 255
  cm <- t(col2rgb("#4DAF4A")) / 255
  cl <- t(col2rgb("#E41A1C")) / 255

  par(mar = c(0, 0, 0, 0))
  plot(0, 0,
    axes = FALSE, xlab = "", ylab = "", type = "n", frame.plot = FALSE,
    xlim = c(-2, 2), ylim = c(-1, 1)
  )

  mapproj::map.grid(c(-180, 180, -90, 90), labels = FALSE, col = "grey")

  points(mp.v.phi ~ mp.v.theta, pch = 20, cex = 1.5, col = c(rep("grey", 4), rgb(cl), rgb(cl), rgb(cm), rgb(cs), rgb(cu)))

  points(mp.p.phi ~ mp.p.theta, ...)
}
