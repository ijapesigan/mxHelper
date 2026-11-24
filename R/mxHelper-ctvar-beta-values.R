#' Starting Values of a Drift Matrix
#'
#' Builds the starting values of the `p` by `p` drift matrix
#' of a continuous-time vector autoregressive model, projected
#' so that every eigenvalue has a negative real part
#' (`simStateSpace::ProjectToHurwitz()`).
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperCTVARBetaValues(
#'   p = 2,
#'   val = NULL
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper
#' @export
MxHelperCTVARBetaValues <- function(p,
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
  .MxHelperCTVARBetaValues(
    p = p,
    val = val
  )
}
