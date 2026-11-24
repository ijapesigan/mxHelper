#' Starting Values of a Full Matrix
#'
#' Builds the starting values of an `m` by `n` matrix
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
#'   Values of the matrix.
#'   A single value is recycled; `NULL` means zeros.
#'
#' @return Returns a numeric matrix.
#'
#' @examples
#' MxHelperFullValues(
#'   m = 2,
#'   n = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperFullValues <- function(m,
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
    na = FALSE
  )
  .MxHelperFullValues(
    m = m,
    n = n,
    val = val
  )
}
