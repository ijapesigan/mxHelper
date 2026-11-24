#' Starting Values of a Transition Matrix (Internal)
#'
#' Builds the starting values of the `p` by `p` transition matrix
#' of a discrete-time vector autoregressive model, projected
#' so that every eigenvalue is inside the unit circle
#' (`simStateSpace::ProjectToStability()`).
#' No input checks: see [MxHelperDTVARBetaValues()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Transition matrix.
#'   If `NULL`, \eqn{0.001} times the identity.
#'
#' @return Returns a numeric matrix.
#'
#' @examples
#' .MxHelperDTVARBetaValues(
#'   p = 2,
#'   val = c(0.5, 0, 0, 0.5)
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperDTVARBetaValues <- function(p,
                                     val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = 0,
      nrow = p,
      ncol = p
    )
    diag(x = val) <- 0.001
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
  simStateSpace::ProjectToStability(x = val)
}
