#' Free Elements of a Diag Matrix (Internal)
#'
#' Builds which elements of the diagonal of a `p` by `p` matrix are free
#' parameters
#' from `NULL`, a single value, a vector, or a matrix.
#' Only the diagonal is kept.
#' No input checks: see [MxHelperDiagFree()].
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
#' .MxHelperDiagFree(
#'   p = 2,
#'   val = c(TRUE, FALSE, TRUE, TRUE)
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperDiagFree <- function(p,
                              val) {
  diag(
    x = .MxHelperFullFree(
      m = p,
      n = p,
      val = val
    )
  )
}
