#' Starting Values of a Covariance Matrix (Internal)
#'
#' Builds the starting values of a `p` by `p` covariance matrix.
#' When an eigenvalue is at most \eqn{10^{-6}}, the matrix is
#' replaced by the nearest positive semidefinite matrix
#' (`Matrix::nearPD()`).
#' No input checks: see [MxHelperSigmaValues()].
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
#' .MxHelperSigmaValues(
#'   p = 2,
#'   val = c(1, 0.5, 0.5, 1)
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaValues <- function(p,
                                 val) {
  if (is.null(x = val)) {
    val <- diag(x = p)
  } else {
    if (is.vector(x = val)) {
      val <- matrix(
        data = val,
        nrow = p,
        ncol = p
      )
    }
    stopifnot(
      is.matrix(x = val),
      dim(x = val) == c(p, p)
    )
  }
  if (
    any(
      eigen(
        x = val,
        symmetric = TRUE,
        only.values = TRUE
      )$values <= 1e-06
    )
  ) {
    val <- as.matrix(
      x = Matrix::nearPD(x = val)$mat
    )
  }
  val
}
