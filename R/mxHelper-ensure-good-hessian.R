#' Fit a Model until Its Hessian Is Good
#'
#' Fits the model until it is a good fit ([MxHelperIsGoodFit()]) with a
#' positive definite Hessian ([MxHelperHasPdHessian()]) and no estimate at
#' an actionable bound ([MxHelperAtBounds()]), for at most `max_attempts`
#' attempts.
#' A model without output starts with a wide and a local search.
#' Each attempt runs the model, nudges estimates off actionable
#' bounds ([MxHelperNudgeOffBounds()]), relaxes bounds that are hit
#' repeatedly or on the last attempt ([MxHelperRelaxBoundsAtBounds()]),
#' starts a wide search when three attempts in a row do not
#' improve, and ends with a local search with a shrinking jitter.
#' The Hessian options are turned on first
#' ([MxHelperForceHessianOptions()]).
#' Candidates are ranked by the criteria they meet, then by the
#' fit value; when the criteria are not met, the best candidate
#' is returned with a warning.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param tries_explore Positive integer.
#'   Extra tries of the wide search
#'   (`OpenMx::mxTryHardWideSearch()`).
#' @param tries_local Positive integer.
#'   Extra tries of the local search (`OpenMx::mxTryHard()`).
#' @param max_attempts Positive integer.
#'   Largest number of rescue attempts.
#' @param grad_tol Positive number.
#'   Largest absolute gradient of a good fit.
#' @param hess_tol_abs Positive number.
#'   Absolute tolerance on the smallest eigenvalue
#'   of the Hessian.
#' @param hess_tol_rel Positive number.
#'   Tolerance on the smallest eigenvalue of the Hessian,
#'   relative to its largest absolute eigenvalue.
#' @param check_condition Logical.
#'   If `TRUE`, the Hessian must also have a condition
#'   number of at most `cond_max`.
#' @param cond_max Positive number.
#'   Largest condition number of the Hessian.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param factor Number greater than 1.
#'   Factor by which a bound is moved away from zero.
#' @param relax_on_last Logical.
#'   If `TRUE`, relax the bounds of parameters at actionable
#'   bounds on the last attempt, or when the same bounds
#'   are hit `relax_streak` times in a row.
#' @param relax_exclude Character vector or `NULL`.
#'   Labels of parameters whose bounds are never relaxed.
#' @param protect_lb_zero Logical.
#'   If `TRUE`, a lower bound of zero is never relaxed.
#' @param ok_codes Integer vector.
#'   OpenMx status codes accepted as converged.
#' @param require_finite_fit Logical.
#'   If `TRUE`, a good fit needs a finite fit value.
#' @param rerun_code6 Logical.
#'   If `TRUE`, run again once after status code 6
#'   (not at a minimum), unless 6 is in `ok_codes`.
#' @param relax_streak Positive integer.
#'   Number of attempts in a row with the same actionable
#'   bound hits before the bounds are relaxed.
#' @param relax_min_attempt Positive integer.
#'   First attempt at which bounds may be relaxed.
#' @param silent Logical.
#'   If `TRUE`, suppress the progress output of OpenMx.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns an OpenMx model: the first that meets the criteria,
#'   or the best candidate. The internal version returns `model`
#'   unchanged when it is not an OpenMx model.
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
#' fit <- MxHelperEnsureGoodHessian(
#'   model = fit
#' )
#' MxHelperHasPdHessian(
#'   x = fit
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperEnsureGoodHessian <- function(model,
                                      tries_explore = 100,
                                      tries_local = 100,
                                      max_attempts = 10,
                                      grad_tol = 1e-2,
                                      hess_tol_abs = 1e-8,
                                      hess_tol_rel = 1e-10,
                                      check_condition = TRUE,
                                      cond_max = 1e12,
                                      abs_bnd_tol = 1e-6,
                                      rel_bnd_tol = 1e-4,
                                      factor = 10,
                                      relax_on_last = TRUE,
                                      relax_exclude = NULL,
                                      protect_lb_zero = TRUE,
                                      ok_codes = 0L,
                                      require_finite_fit = TRUE,
                                      rerun_code6 = TRUE,
                                      relax_streak = 3,
                                      relax_min_attempt = 3,
                                      silent = TRUE,
                                      allowed_bounds = NULL) {
  .CheckMxModel(
    x = model,
    arg = "model"
  )
  .CheckCount(
    x = tries_explore,
    arg = "tries_explore"
  )
  .CheckCount(
    x = tries_local,
    arg = "tries_local"
  )
  .CheckCount(
    x = max_attempts,
    arg = "max_attempts"
  )
  .CheckPositive(
    x = grad_tol,
    arg = "grad_tol"
  )
  .CheckPositive(
    x = hess_tol_abs,
    arg = "hess_tol_abs"
  )
  .CheckPositive(
    x = hess_tol_rel,
    arg = "hess_tol_rel"
  )
  .CheckFlag(
    x = check_condition,
    arg = "check_condition"
  )
  .CheckPositive(
    x = cond_max,
    arg = "cond_max"
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
    x = factor,
    arg = "factor"
  )
  .CheckFlag(
    x = relax_on_last,
    arg = "relax_on_last"
  )
  .CheckLabels(
    x = relax_exclude,
    arg = "relax_exclude"
  )
  .CheckFlag(
    x = protect_lb_zero,
    arg = "protect_lb_zero"
  )
  .CheckCodes(
    x = ok_codes,
    arg = "ok_codes"
  )
  .CheckFlag(
    x = require_finite_fit,
    arg = "require_finite_fit"
  )
  .CheckFlag(
    x = rerun_code6,
    arg = "rerun_code6"
  )
  .CheckCount(
    x = relax_streak,
    arg = "relax_streak"
  )
  .CheckCount(
    x = relax_min_attempt,
    arg = "relax_min_attempt"
  )
  .CheckFlag(
    x = silent,
    arg = "silent"
  )
  .MxHelperEnsureGoodHessian(
    model = model,
    tries_explore = tries_explore,
    tries_local = tries_local,
    max_attempts = max_attempts,
    grad_tol = grad_tol,
    hess_tol_abs = hess_tol_abs,
    hess_tol_rel = hess_tol_rel,
    check_condition = check_condition,
    cond_max = cond_max,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    factor = factor,
    relax_on_last = relax_on_last,
    relax_exclude = relax_exclude,
    protect_lb_zero = protect_lb_zero,
    ok_codes = ok_codes,
    require_finite_fit = require_finite_fit,
    rerun_code6 = rerun_code6,
    relax_streak = relax_streak,
    relax_min_attempt = relax_min_attempt,
    silent = silent,
    allowed_bounds = allowed_bounds
  )
}
