#' Starting Values of a Transition Matrix
#'
#' Builds the starting values of the `p` by `p` transition matrix
#' of a discrete-time vector autoregressive model, projected
#' so that every eigenvalue is inside the unit circle
#' (`simStateSpace::ProjectToStability()`).
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperDTVARBetaValues(
#'   p = 2,
#'   val = c(0.5, 0, 0, 0.5)
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper
#' @export
MxHelperDTVARBetaValues <- function(p,
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
  .MxHelperDTVARBetaValues(
    p = p,
    val = val
  )
}
