#' Starting Values of a Sym Matrix
#'
#' Builds the starting values of a `p` by `p` symmetric matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The lower triangle is copied to the upper triangle.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperSymValues(
#'   p = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSymValues <- function(p,
                              val) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckVal(
    x = val,
    arg = "val",
    mode = "numeric",
    na = FALSE
  )
  .MxHelperSymValues(
    p = p,
    val = val
  )
}
