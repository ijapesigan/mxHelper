#' Bounds of a Full Matrix
#'
#' Builds the lower or the upper bounds of an `m` by `n` matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperFullBound(
#'   m = 2,
#'   n = 2,
#'   val = 0
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperFullBound <- function(m,
                              n,
                              val) {
  .CheckCount(
    x = m,
    arg = "m"
  )
  .CheckCount(
    x = n,
    arg = "n"
  )
  .CheckVal(
    x = val,
    arg = "val",
    mode = "numeric",
    na = TRUE
  )
  .MxHelperFullBound(
    m = m,
    n = n,
    val = val
  )
}
