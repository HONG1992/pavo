#' Segment classification
#'
#' Calculates segment classification measures as defined in Endler (1990).
#'
#' @param vismodeldata (required) quantum catch color data. Can be either the result
#'  from \code{\link{vismodel}} or independently calculated data (in the form of a data frame
#'  with columns named 'S1', 'S2', 'S3', 'S4', and, optionally, 'lum', representing a generic
#'  'tetrachromatic' viewer).
#'
#' @return A data frame of class \code{colspace} consisting of the following columns:
#' @return \code{S1}, \code{S2}, \code{S3}, \code{S4}: the relative reflectance at each
#' of the four segments.
#' @return \code{LM}, \code{MS}: segment scores
#' @return \code{C}, \code{H}, \code{B}: 'chroma', 'hue' (degrees), and 'brightness' in the segment classification space
#'
#' @export
#'
#' @keywords internal
#'
#' @examples \dontrun{
#' data(sicalis)
#' vis.sic <- vismodel(sicalis, visual = 'segment', achromatic = 'all')
#' seg.sic <- colspace(vis.sic, space = 'segment')
#' }
#'
#' @author Thomas White \email{thomas.white026@@gmail.com}
#' @author Pierre-Paul Bitton \email{bittonp@@uwindsor.ca}
#'
#' @references Endler, J. A. (1990) On the measurement and classification of
#' color in studies of animal color patterns. Biological Journal of the Linnean
#' Society, 41, 315-352.

segspace <- function(vismodeldata) {
  dat <- vismodeldata

  # if object is vismodel:
  if ("vismodel" %in% attr(dat, "class")) {

    # check if tetrachromat
    if (attr(dat, "conenumb") < 4) {
      stop("vismodel input is not tetrachromatic", call. = FALSE)
    }

    if (attr(dat, "conenumb") != "seg" & attr(dat, "conenumb") > 4) {
      warning("vismodel input is not tetrachromatic, considering first four columns only", call. = FALSE)
    }

    # check if relative
    if (!attr(dat, "relative")) {
      dat <- dat[, 1:4]
      dat <- dat / apply(dat, 1, sum)
      class(dat) <- class(vismodeldata)
      warning("Quantum catch are not relative, and have been transformed", call. = FALSE)
      attr(vismodeldata, "relative") <- TRUE
    }
  }

  # if not, check if it has more (or less) than 4 columns

  if (!("vismodel" %in% attr(dat, "class"))) {
    if (ncol(dat) < 4) {
      stop("Input data is not a ", dQuote("vismodel"), " object and has fewer than four columns", call. = FALSE)
    }
    if (ncol(dat) == 4) {
      warning("Input data is not a ", dQuote("vismodel"), " object; treating columns as unstandardized quantum catch for ", dQuote("S1"), ", ", dQuote("S2"), ", ", dQuote("S3"), ", and ", dQuote("S4"), " segments, respectively", call. = FALSE)
    }

    if (ncol(dat) > 4) {
      warning("Input data is not a ", dQuote("vismodel"), " object *and* has more than four columns; treating the first four columns as unstandardized quantum catch for ", dQuote("S1"), ", ", dQuote("S2"), ", ", dQuote("S3"), ", and ", dQuote("S4"), " segments, respectively", call. = FALSE)
    }

    dat <- dat[, 1:4]
    names(dat) <- c("S1", "S2", "S3", "S4")

    dat <- dat / apply(dat, 1, sum)
    warning("Quantum catch have been transformed to be relative (sum of 1)", call. = FALSE)
    attr(vismodeldata, "relative") <- TRUE
  }

  if (all(c("S1", "S2", "S3", "S4") %in% names(dat))) {
    Q1 <- dat[, "S1"]
    Q2 <- dat[, "S2"]
    Q3 <- dat[, "S3"]
    Q4 <- dat[, "S4"]
  } else {
    warning("Could not find columns named ", dQuote("S1"), ", ", dQuote("S2"), ", ", dQuote("S3"), ", and ", dQuote("S4"), ", using first four columns instead.", call. = FALSE)
    Q1 <- dat[, 1]
    Q2 <- dat[, 2]
    Q3 <- dat[, 3]
    Q4 <- dat[, 4]
  }

  B <- dat$lum

  # LM/MS

  LM <- Q4 - Q2
  MS <- Q3 - Q1

  # Colormetrics
  C <- sqrt(LM^2 + MS^2)
  H <- asin(MS / C) * (180 / pi)

  res.p <- data.frame(S1 = Q1, S2 = Q2, S3 = Q3, S4 = Q4, LM, MS, C, H, B, row.names = rownames(dat))

  res <- res.p

  class(res) <- c("colspace", "data.frame")

  # Descriptive attributes (largely preserved from vismodel)
  attr(res, "clrsp") <- "segment"
  attr(res, "conenumb") <- 4
  attr(res, "qcatch") <- attr(vismodeldata, "qcatch")
  attr(res, "visualsystem.chromatic") <- attr(vismodeldata, "visualsystem.chromatic")
  attr(res, "visualsystem.achromatic") <- attr(vismodeldata, "visualsystem.achromatic")
  attr(res, "illuminant") <- attr(vismodeldata, "illuminant")
  attr(res, "background") <- attr(vismodeldata, "background")
  attr(res, "relative") <- attr(vismodeldata, "relative")
  attr(res, "vonkries") <- attr(vismodeldata, "vonkries")

  # Data attributes
  attr(res, "data.visualsystem.chromatic") <- attr(vismodeldata, "data.visualsystem.chromatic")
  attr(res, "data.visualsystem.achromatic") <- attr(vismodeldata, "data.visualsystem.achromatic")
  attr(res, "data.background") <- attr(vismodeldata, "data.background")

  res
}
