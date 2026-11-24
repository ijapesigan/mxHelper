#' Free Elements of a Diag Matrix
#'
#' Builds which elements of the diagonal of a `p` by `p` matrix are free
#' parameters
#' from `NULL`, a single value, a vector, or a matrix.
#' Only the diagonal is kept.
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
#' @return Returns a logical vector of length `p`.
#'
#' @examples
#' MxHelperDiagFree(
#'   p = 2,
#'   val = c(TRUE, FALSE, TRUE, TRUE)
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperDiagFree <- function(p,
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
  .MxHelperDiagFree(
    p = p,
    val = val
  )
}
