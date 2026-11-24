#' Bounds of a Diag Matrix
#'
#' Builds the lower or the upper bounds of the diagonal of a `p` by `p` matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' Only the diagonal is kept.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperDiagBound(
#'   p = 2,
#'   val = 0
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperDiagBound <- function(p,
                              val) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckVal(
    x = val,
    arg = "val",
    mode = "numeric",
    na = TRUE
  )
  .MxHelperDiagBound(
    p = p,
    val = val
  )
}
