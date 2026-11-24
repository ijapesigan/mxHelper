#' Softplus
#'
#' Computes the softplus
#' \eqn{\log \left( 1 + \exp \left( x \right) \right)}
#' elementwise, in a form that does not overflow:
#' \eqn{\left( x + \left| x \right| \right) / 2 +
#' \log \left( 1 + \exp \left( - \left| x \right| \right)
#' \right)}.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric vector or matrix.
#'
#' @return Returns a numeric vector or matrix of the shape of `x`,
#'   with positive elements.
#'
#' @examples
#' MxHelperSoftplus(
#'   x = c(-1, 0, 1)
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSoftplus <- function(x) {
  .CheckNumeric(
    x = x,
    arg = "x"
  )
  .MxHelperSoftplus(
    x = x
  )
}
