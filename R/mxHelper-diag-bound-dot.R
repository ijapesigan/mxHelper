#' Bounds of a Diag Matrix (Internal)
#'
#' Builds the lower or the upper bounds of the diagonal of a `p` by `p` matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' Only the diagonal is kept.
#' No input checks: see [MxHelperDiagBound()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Bounds of the matrix.
#'   A single value is recycled; `NULL` or `NA` means none.
#'
#' @return Returns a numeric vector of length `p`, with `NA` where there is no
#'   bound.
#'
#' @examples
#' .MxHelperDiagBound(
#'   p = 2,
#'   val = 0
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperDiagBound <- function(p,
                               val) {
  diag(
    x = .MxHelperFullBound(
      m = p,
      n = p,
      val = val
    )
  )
}
