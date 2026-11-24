#' Bounds of a Sym Matrix (Internal)
#'
#' Builds the lower or the upper bounds of a `p` by `p` symmetric matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The lower triangle is copied to the upper triangle.
#' No input checks: see [MxHelperSymBound()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Bounds of the matrix.
#'   A single value is recycled; `NULL` or `NA` means none.
#'
#' @return Returns a numeric matrix, with `NA` where there is no bound.
#'
#' @examples
#' .MxHelperSymBound(
#'   p = 2,
#'   val = 0
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSymBound <- function(p,
                              val) {
  out <- .MxHelperFullBound(
    m = p,
    n = p,
    val = val
  )
  out[upper.tri(x = out)] <- t(x = out)[upper.tri(x = out)]
  out
}
