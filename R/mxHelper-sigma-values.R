#' Starting Values of a Covariance Matrix
#'
#' Builds the starting values of a `p` by `p` covariance matrix.
#' When an eigenvalue is at most \eqn{10^{-6}}, the matrix is
#' replaced by the nearest positive semidefinite matrix
#' (`Matrix::nearPD()`).
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Covariance matrix. If `NULL`, the identity.
#'
#' @return Returns a numeric matrix.
#'
#' @examples
#' MxHelperSigmaValues(
#'   p = 2,
#'   val = c(1, 0.5, 0.5, 1)
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper
#' @export
MxHelperSigmaValues <- function(p,
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
  .MxHelperSigmaValues(
    p = p,
    val = val
  )
}
