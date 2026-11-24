#' Free Elements of a Sdiag Matrix (Internal)
#'
#' Builds which elements of a `p` by `p` strictly lower triangular matrix are
#' free parameters
#' from `NULL`, a single value, a vector, or a matrix.
#' The diagonal and the upper triangle are never free.
#' No input checks: see [MxHelperSdiagFree()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Logical vector or matrix, or `NULL`.
#'   Which elements are free parameters.
#'   A single value is recycled; `NULL` means all free.
#'
#' @return Returns a logical matrix.
#'
#' @examples
#' .MxHelperSdiagFree(
#'   p = 2,
#'   val = c(TRUE, FALSE, TRUE, TRUE)
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSdiagFree <- function(p,
                               val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = TRUE,
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
  ] <- FALSE
  val
}
