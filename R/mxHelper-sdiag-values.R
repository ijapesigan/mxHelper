#' Starting Values of a Sdiag Matrix
#'
#' Builds the starting values of a `p` by `p` strictly lower triangular matrix
#' from `NULL`, a single value, a vector, or a matrix.
#' The diagonal and the upper triangle are set to
#' the value of a fixed element.
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
#' MxHelperSdiagValues(
#'   p = 2,
#'   val = c(1, 2, 3, 4)
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSdiagValues <- function(p,
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
  .MxHelperSdiagValues(
    p = p,
    val = val
  )
}
