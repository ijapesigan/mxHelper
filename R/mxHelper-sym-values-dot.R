#' Starting Values of a Sym Matrix (Internal)
#'
#' Builds the starting values of a `p` by `p` symmetric matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The lower triangle is copied to the upper triangle.
#' No input checks: see [MxHelperSymValues()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Values of the matrix.
#'   A single value is recycled; `NULL` means zeros.
#'
#' @return Returns a numeric matrix.
#'
#' @examples
#' .MxHelperSymValues(
#'   p = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSymValues <- function(p,
                               val) {
  out <- .MxHelperFullValues(
    m = p,
    n = p,
    val = val
  )
  out[upper.tri(x = out)] <- t(x = out)[upper.tri(x = out)]
  out
}
