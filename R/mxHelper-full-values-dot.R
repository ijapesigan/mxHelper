#' Starting Values of a Full Matrix (Internal)
#'
#' Builds the starting values of an `m` by `n` matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' No input checks: see [MxHelperFullValues()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param m Positive integer.
#'   Number of rows.
#' @param n Positive integer.
#'   Number of columns.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Values of the matrix.
#'   A single value is recycled; `NULL` means zeros.
#'
#' @return Returns a numeric matrix.
#'
#' @examples
#' .MxHelperFullValues(
#'   m = 2,
#'   n = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperFullValues <- function(m,
                                n,
                                val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = 0,
      nrow = m,
      ncol = n
    )
  } else {
    if (is.vector(x = val)) {
      if (length(x = val) == 1) {
        val <- rep(
          x = val,
          times = m * n
        )
      }
      stopifnot(
        length(x = val) == m * n
      )
      val <- matrix(
        data = val,
        nrow = m,
        ncol = n
      )
    }
    stopifnot(
      is.matrix(x = val),
      dim(x = val) == c(m, n)
    )
  }
  val
}
