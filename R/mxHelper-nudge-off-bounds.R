#' Move Estimates off Their Bounds
#'
#' Moves each estimate at an actionable bound ([MxHelperAtBounds()])
#' inward by `mult` times the bound tolerance, without crossing
#' the opposite bound. Other estimates are unchanged.
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
#' @param mult Positive number.
#'   Multiple of the bound tolerance by which an estimate
#'   is moved inward.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns the model with the new values.
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
#' fit <- MxHelperNudgeOffBounds(
#'   x = fit
#' )
#'
#' @family Bounds Functions
#' @keywords mxHelper
#' @export
MxHelperNudgeOffBounds <- function(x,
                                   abs_bnd_tol = 1e-6,
                                   rel_bnd_tol = 1e-4,
                                   mult = 10,
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
  .CheckPositive(
    x = mult,
    arg = "mult"
  )
  .MxHelperNudgeOffBounds(
    x = x,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    mult = mult,
    allowed_bounds = allowed_bounds
  )
}
