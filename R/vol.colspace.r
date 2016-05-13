#' Plot a 3D Convex Hull in a Tetrahedral Colorspace
#'
#' \code{vol.colspace} produces a 3D convex hull in tetrahedral color space (i.e. when 
#' \strong{\code{space = 'tcs'}})
#'
#' @return \code{vol.colspace} creates a 3D convex hull within a \code{plot.colspace} object, 
#'  only when \strong{\code{space = 'tcs'}}. 
#'  
#' @rdname plot.colspace
#'
#' @export

vol.colspace <- function(clrspdata, ...){
  
  if(attr(clrspdata, 'clrsp') == 'tcs'){
    .tcsvol(clrspdata, ...)
  }
  
}