#' Relax the Bounds That Estimates Are at
#'
#' Moves each finite bound that an estimate is at ([MxHelperAtBounds()])
#' away from zero by `factor`: a negative bound is multiplied by
#' it, a positive one divided. When the new bounds of a
#' parameter cross, they are set around their midpoint.
#' Unlike [MxHelperRelaxBoundsAtBounds()], it ignores `allowed_bounds`
#' and relaxes a lower bound of zero unchanged (zero stays
#' zero).
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
#' @param labels Character vector or `NULL`.
#'   Labels of the only parameters whose bounds may be relaxed.
#'   If `NULL`, all.
#' @param exclude Character vector or `NULL`.
#'   Labels of parameters whose bounds are never relaxed.
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
#' fit <- MxHelperRelaxBounds(
#'   x = fit
#' )
#'
#' @family Bounds Functions
#' @keywords mxHelper
#' @export
MxHelperRelaxBounds <- function(x,
                                factor = 10,
                                abs_bnd_tol = 1e-6,
                                rel_bnd_tol = 1e-4,
                                labels = NULL,
                                exclude = NULL) {
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
    x = labels,
    arg = "labels"
  )
  .CheckLabels(
    x = exclude,
    arg = "exclude"
  )
  .MxHelperRelaxBounds(
    x = x,
    factor = factor,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    labels = labels,
    exclude = exclude
  )
}
