#' Starting Values of a Drift Matrix (Internal)
#'
#' Builds the starting values of the `p` by `p` drift matrix
#' of a continuous-time vector autoregressive model, projected
#' so that every eigenvalue has a negative real part
#' (`simStateSpace::ProjectToHurwitz()`).
#' No input checks: see [MxHelperCTVARBetaValues()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Drift matrix. If `NULL`, \eqn{-0.1} times the identity.
#'
#' @return Returns a numeric matrix.
#'
#' @examples
#' .MxHelperCTVARBetaValues(
#'   p = 2,
#'   val = NULL
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperCTVARBetaValues <- function(p,
                                     val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = 0,
      nrow = p,
      ncol = p
    )
    diag(x = val) <- -0.1
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
  simStateSpace::ProjectToHurwitz(x = val)
}
