#' Bounds of a Sdiag Matrix (Internal)
#'
#' Builds the lower or the upper bounds of a `p` by `p` strictly lower
#' triangular matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The diagonal and the upper triangle have no bounds.
#' No input checks: see [MxHelperSdiagBound()].
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
#' .MxHelperSdiagBound(
#'   p = 2,
#'   val = c(0, -1, 0, 0)
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSdiagBound <- function(p,
                                val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = NA,
      nrow = p,
      ncol = p
    )
  } else {
    if (is.vector(x = val)) {
      val <- matrix(
        data = val,
        nrow = p,
        ncol = p
      )
    }
    stopifnot(
      is.matrix(x = val),
      dim(x = val) == c(p, p)
    )
  }
  val[
    upper.tri(
      x = val,
      diag = TRUE
    )
  ] <- NA
  val
}
