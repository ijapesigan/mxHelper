#' Free Elements of a Full Matrix (Internal)
#'
#' Builds which elements of an `m` by `n` matrix are free parameters
#' from `NULL`, a single value, a vector, or a matrix.
#' No input checks: see [MxHelperFullFree()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param m Positive integer.
#'   Number of rows.
#' @param n Positive integer.
#'   Number of columns.
#' @param val Logical vector or matrix, or `NULL`.
#'   Which elements are free parameters.
#'   A single value is recycled; `NULL` means all free.
#'
#' @return Returns a logical matrix.
#'
#' @examples
#' .MxHelperFullFree(
#'   m = 2,
#'   n = 2,
#'   val = c(TRUE, FALSE, TRUE, TRUE)
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperFullFree <- function(m,
                              n,
                              val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = TRUE,
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
