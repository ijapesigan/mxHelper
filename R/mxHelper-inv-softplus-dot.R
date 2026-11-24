#' Inverse Softplus (Internal)
#'
#' Computes the inverse of the softplus,
#' \eqn{\log \left( \exp \left( x \right) - 1 \right)},
#' elementwise; for \eqn{x > 20}, as
#' \eqn{x + \log \left( 1 - \exp \left( - x \right) \right)}
#' to avoid overflow.
#' Stops with an error when an element is not positive.
#' No input checks: see [MxHelperInvSoftplus()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric vector or matrix with positive elements.
#'
#' @return Returns a numeric vector or matrix of the shape of `x`.
#'
#' @examples
#' .MxHelperInvSoftplus(
#'   x = c(0.5, 1, 2)
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperInvSoftplus <- function(x) {
  if (any(x <= 0, na.rm = TRUE)) {
    stop(
      ".MxHelperInvSoftplus() requires strictly positive input."
    )
  }
  out <- log(x = expm1(x = x))
  big <- x > 20
  out[big] <- x[big] + log1p(x = -exp(x = -x[big]))
  out
}
