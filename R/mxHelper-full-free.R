#' Free Elements of a Full Matrix
#'
#' Builds which elements of an `m` by `n` matrix are free parameters
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
#' @param val Logical vector or matrix, or `NULL`.
#'   Which elements are free parameters.
#'   A single value is recycled; `NULL` means all free.
#'
#' @return Returns a logical matrix.
#'
#' @examples
#' MxHelperFullFree(
#'   m = 2,
#'   n = 2,
#'   val = c(TRUE, FALSE, TRUE, TRUE)
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperFullFree <- function(m,
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
    mode = "logical",
    na = FALSE
  )
  .MxHelperFullFree(
    m = m,
    n = n,
    val = val
  )
}
