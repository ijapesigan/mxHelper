#' Which Estimates Are at a Bound?
#'
#' Finds the free parameters whose estimates are at their lower
#' or upper bound, within
#' \eqn{\tau_{\mathrm{abs}} + \tau_{\mathrm{rel}}
#' \max \left( \left| \hat{\theta} \right|, \left| b \right|,
#' 1 \right)}.
#' A hit is actionable unless the parameter is listed in
#' `allowed_bounds` for that side.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns a list with the elements
#'   \describe{
#'     \item{any}{`TRUE` if any estimate is at a bound.}
#'     \item{actionable}{`TRUE` if any hit is actionable.}
#'     \item{at_lb, at_ub}{Named logical vectors: at the lower,
#'       at the upper bound.}
#'     \item{actionable_lb, actionable_ub}{The same, actionable hits
#'       only.}
#'   }
#'
#' @examples
#' set.seed(seed = 42)
#' x <- data.frame(
#'   y1 = rnorm(n = 50),
#'   y2 = rnorm(n = 50)
#' )
#' fit <- MxHelperQuiet(
#'   expr = MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' MxHelperAtBounds(
#'   x = fit
#' )$any
#'
#' @family Bounds Functions
#' @keywords mxHelper
#' @export
MxHelperAtBounds <- function(x,
                             abs_bnd_tol = 1e-6,
                             rel_bnd_tol = 1e-4,
                             allowed_bounds = NULL) {
  .CheckMxModel(
    x = x,
    arg = "x"
  )
  .CheckPositive(
    x = abs_bnd_tol,
    arg = "abs_bnd_tol"
  )
  .CheckPositive(
    x = rel_bnd_tol,
    arg = "rel_bnd_tol"
  )
  .MxHelperAtBounds(
    x = x,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    allowed_bounds = allowed_bounds
  )
}
