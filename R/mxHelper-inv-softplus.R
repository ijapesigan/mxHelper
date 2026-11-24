#' Inverse Softplus
#'
#' Computes the inverse of the softplus,
#' \eqn{\log \left( \exp \left( x \right) - 1 \right)},
#' elementwise; for \eqn{x > 20}, as
#' \eqn{x + \log \left( 1 - \exp \left( - x \right) \right)}
#' to avoid overflow.
#' Stops with an error when an element is not positive.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric vector or matrix with positive elements.
#'
#' @return Returns a numeric vector or matrix of the shape of `x`.
#'
#' @examples
#' MxHelperInvSoftplus(
#'   x = c(0.5, 1, 2)
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperInvSoftplus <- function(x) {
  .CheckNumeric(
    x = x,
    arg = "x"
  )
  .MxHelperInvSoftplus(
    x = x
  )
}
