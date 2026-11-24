#' Does the Fit Need a Rescue?
#'
#' Tests whether a model needs another fit: its status code is
#' missing or not in `ok_codes`, it is not a good fit
#' ([MxHelperIsGoodFit()]), its Hessian is not positive definite
#' ([MxHelperHasPdHessian()]), or an estimate is at an actionable bound
#' ([MxHelperAtBounds()]). When a test fails with an error, the answer
#' is `TRUE`.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param grad_tol Positive number.
#'   Largest absolute gradient of a good fit.
#' @param ok_codes Integer vector.
#'   OpenMx status codes accepted as converged.
#' @param require_finite_fit Logical.
#'   If `TRUE`, a good fit needs a finite fit value.
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
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns `TRUE` or `FALSE`.
#'   The internal version returns `TRUE` when `model` is not an
#'   OpenMx model.
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
#' MxHelperNeedsRescue(
#'   model = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper
#' @export
MxHelperNeedsRescue <- function(model,
                                grad_tol = 1e-2,
                                ok_codes = 0L,
                                require_finite_fit = TRUE,
                                hess_tol_abs = 1e-8,
                                hess_tol_rel = 1e-10,
                                check_condition = TRUE,
                                cond_max = 1e12,
                                abs_bnd_tol = 1e-6,
                                rel_bnd_tol = 1e-4,
                                allowed_bounds = NULL) {
  .CheckMxModel(
    x = model,
    arg = "model"
  )
  .CheckPositive(
    x = grad_tol,
    arg = "grad_tol"
  )
  .CheckCodes(
    x = ok_codes,
    arg = "ok_codes"
  )
  .CheckFlag(
    x = require_finite_fit,
    arg = "require_finite_fit"
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
  .MxHelperNeedsRescue(
    model = model,
    grad_tol = grad_tol,
    ok_codes = ok_codes,
    require_finite_fit = require_finite_fit,
    hess_tol_abs = hess_tol_abs,
    hess_tol_rel = hess_tol_rel,
    check_condition = check_condition,
    cond_max = cond_max,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    allowed_bounds = allowed_bounds
  )
}
