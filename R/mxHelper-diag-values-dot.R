#' Starting Values of a Diag Matrix (Internal)
#'
#' Builds the starting values of the diagonal of a `p` by `p` matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' Only the diagonal is kept.
#' No input checks: see [MxHelperDiagValues()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Values of the matrix.
#'   A single value is recycled; `NULL` means zeros.
#'
#' @return Returns a numeric vector of length `p`.
#'
#' @examples
#' .MxHelperDiagValues(
#'   p = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperDiagValues <- function(p,
                                val) {
  diag(
    x = .MxHelperFullValues(
      m = p,
      n = p,
      val = val
    )
  )
}
