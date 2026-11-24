#' Bounds of a Sdiag Matrix
#'
#' Builds the lower or the upper bounds of a `p` by `p` strictly lower
#' triangular matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The diagonal and the upper triangle have no bounds.
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
#' @return Returns a numeric matrix, with `NA` where there is no bound.
#'
#' @examples
#' MxHelperSdiagBound(
#'   p = 2,
#'   val = c(0, -1, 0, 0)
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSdiagBound <- function(p,
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
  .MxHelperSdiagBound(
    p = p,
    val = val
  )
}
