#' Is the Hessian Positive Definite?
#'
#' Tests whether the Hessian of a fitted model is positive
#' definite: its smallest eigenvalue exceeds
#' \eqn{\tau_{\mathrm{abs}} + \tau_{\mathrm{rel}}
#' \max \left( 1, \max_{i} \left| \lambda_{i} \right| \right)}.
#' With `check_condition = TRUE`, its condition number must also
#' be at most `cond_max`. A missing Hessian counts as not
#' positive definite.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
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
#'
#' @return Returns `TRUE` or `FALSE`.
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
#' MxHelperHasPdHessian(
#'   x = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper
#' @export
MxHelperHasPdHessian <- function(x,
                                 hess_tol_abs = 1e-8,
                                 hess_tol_rel = 1e-10,
                                 check_condition = FALSE,
                                 cond_max = 1e12) {
  .CheckMxModel(
    x = x,
    arg = "x"
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
  .MxHelperHasPdHessian(
    x = x,
    hess_tol_abs = hess_tol_abs,
    hess_tol_rel = hess_tol_rel,
    check_condition = check_condition,
    cond_max = cond_max
  )
}
