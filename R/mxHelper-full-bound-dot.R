#' Bounds of a Full Matrix (Internal)
#'
#' Builds the lower or the upper bounds of an `m` by `n` matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' No input checks: see [MxHelperFullBound()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param m Positive integer.
#'   Number of rows.
#' @param n Positive integer.
#'   Number of columns.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Bounds of the matrix.
#'   A single value is recycled; `NULL` or `NA` means none.
#'
#' @return Returns a numeric matrix, with `NA` where there is no bound.
#'
#' @examples
#' .MxHelperFullBound(
#'   m = 2,
#'   n = 2,
#'   val = 0
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperFullBound <- function(m,
                               n,
                               val) {
  if (is.null(x = val) || all(is.na(x = val))) {
    val <- matrix(
      data = NA,
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
