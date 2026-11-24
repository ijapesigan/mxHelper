#' Relax the Actionable Bounds That Estimates Are at
#'
#' Moves each finite bound that an estimate is at, when the hit
#' is actionable ([MxHelperAtBounds()]), away from zero by `factor`:
#' a negative bound is multiplied by it, a positive one divided.
#' With `protect_lb_zero = TRUE`, a lower bound of zero is kept.
#' When the new bounds of a parameter cross, they are set around
#' their midpoint. Stops with an error unless `factor > 1`.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
#' @param factor Number greater than 1.
#'   Factor by which a bound is moved away from zero.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param exclude Character vector or `NULL`.
#'   Labels of parameters whose bounds are never relaxed.
#' @param protect_lb_zero Logical.
#'   If `TRUE`, a lower bound of zero is never relaxed.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns the model with the new bounds.
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
#' fit <- MxHelperRelaxBoundsAtBounds(
#'   x = fit
#' )
#'
#' @family Bounds Functions
#' @keywords mxHelper
#' @export
MxHelperRelaxBoundsAtBounds <- function(x,
                                        factor = 10,
                                        abs_bnd_tol = 1e-6,
                                        rel_bnd_tol = 1e-4,
                                        exclude = NULL,
                                        protect_lb_zero = TRUE,
                                        allowed_bounds = NULL) {
  .CheckMxModel(
    x = x,
    arg = "x"
  )
  .CheckPositive(
    x = factor,
    arg = "factor"
  )
  .CheckPositive(
    x = abs_bnd_tol,
    arg = "abs_bnd_tol"
  )
  .CheckPositive(
    x = rel_bnd_tol,
    arg = "rel_bnd_tol"
  )
  .CheckLabels(
    x = exclude,
    arg = "exclude"
  )
  .CheckFlag(
    x = protect_lb_zero,
    arg = "protect_lb_zero"
  )
  .MxHelperRelaxBoundsAtBounds(
    x = x,
    factor = factor,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    exclude = exclude,
    protect_lb_zero = protect_lb_zero,
    allowed_bounds = allowed_bounds
  )
}
