#' Starting Values of a Sdiag Matrix (Internal)
#'
#' Builds the starting values of a `p` by `p` strictly lower triangular matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The diagonal and the upper triangle are set to
#' the value of a fixed element.
#' No input checks: see [MxHelperSdiagValues()].
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
#' .MxHelperSdiagValues(
#'   p = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSdiagValues <- function(p,
                                 val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = 0,
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
  ] <- 0
  val
}
