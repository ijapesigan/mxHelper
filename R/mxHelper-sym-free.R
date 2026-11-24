#' Free Elements of a Sym Matrix
#'
#' Builds which elements of a `p` by `p` symmetric matrix are free parameters
#' from `NULL`, a single value, a vector, or a matrix.
#' The lower triangle is copied to the upper triangle.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperSymFree(
#'   p = 2,
#'   val = c(TRUE, FALSE, TRUE, TRUE)
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSymFree <- function(p,
                            val) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckVal(
    x = val,
    arg = "val",
    mode = "logical",
    na = FALSE
  )
  .MxHelperSymFree(
    p = p,
    val = val
  )
}
