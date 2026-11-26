#' Read, Fit, and Save a Model (Internal)
#'
#' Reads an OpenMx model from an `.rds` file, fits it
#' (`.MxHelperEnsureGoodHessian()`, or `OpenMx::mxTryHard()` with
#' `check_hess = FALSE`), and saves the fit to the same file,
#' for simulations that keep each replication in its own file.
#' Errors and warnings are recorded, not thrown.
#' No input checks: see [MxHelperReadRunSave()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param input Character string.
#'   Path of an `.rds` file that holds an OpenMx model.
#'   The fitted model is saved back to the same file.
#' @param tries_explore Positive integer.
#'   Extra tries of the wide search
#'   (`OpenMx::mxTryHardWideSearch()`).
#' @param tries_local Positive integer.
#'   Extra tries of the local search (`OpenMx::mxTryHard()`).
#' @param max_attempts Positive integer.
#'   Largest number of rescue attempts.
#' @param grad_tol Positive number.
#'   Largest absolute gradient of a good fit.
#' @param nd_tol Non-negative number or `NULL`.
#'   Largest Newton decrement of a good fit: a fit that fails
#'   `grad_tol` is still good when `g' H^{-1} g < nd_tol`, with `g`
#'   the gradient and `H` the Hessian (positive definite) of the fit.
#'   `NULL` or `0` switches this test off.
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
#' @param check_hess Logical.
#'   If `TRUE`, fit with the Hessian rescue
#'   (`EnsureGoodHessian`);
#'   if `FALSE`, with `OpenMx::mxTryHard()` only.
#' @param save_conditions Logical.
#'   If `TRUE`, an error is saved to `input`
#'   as attributes of the object read from it.
#' @param muffle_warnings Logical.
#'   If `TRUE`, warnings are recorded but not shown.
#'
#' @return Returns the fitted model as read back from `input`.
#'   Warnings are in the attribute `mx_fit_warnings`.
#'   On an error, the object in `input` (or an empty list)
#'   with the attributes `mx_fit_error`, `mx_fit_error_call`, and
#'   `mx_fit_error_time`.
#'
#' @examples
#' set.seed(seed = 42)
#' x <- data.frame(
#'   y1 = rnorm(n = 50),
#'   y2 = rnorm(n = 50)
#' )
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' input <- tempfile(fileext = ".rds")
#' saveRDS(object = fit, file = input)
#' fit <- .MxHelperReadRunSave(
#'   input = input,
#'   silent = TRUE
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperReadRunSave <- function(input,
                                 tries_explore = 100,
                                 tries_local = 100,
                                 max_attempts = 10,
                                 grad_tol = 1e-2,
                                 nd_tol = 1e-4,
                                 hess_tol_abs = 1e-8,
                                 hess_tol_rel = 1e-10,
                                 check_condition = FALSE,
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
                                 silent = FALSE,
                                 check_hess = TRUE,
                                 save_conditions = TRUE,
                                 muffle_warnings = TRUE) {
  warn_msg <- character(length = 0)
  out <- withCallingHandlers(
    expr = tryCatch(
      expr = {
        model <- readRDS(
          file = input
        )
        fit <- if (check_hess) {
          .MxHelperEnsureGoodHessian(
            model = model,
            tries_explore = tries_explore,
            tries_local = tries_local,
            max_attempts = max_attempts,
            grad_tol = grad_tol,
            nd_tol = nd_tol,
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
            silent = silent
          )
        } else {
          OpenMx::mxTryHard(
            model = model,
            silent = silent
          )
        }
        if (length(x = warn_msg) > 0) {
          attr(x = fit, which = "mx_fit_warnings") <- unique(x = warn_msg)
        }
        saveRDS(object = fit, file = input)
        readRDS(file = input)
      },
      error = function(e) {
        if (!silent) {
          message("Error while fitting model: ", conditionMessage(c = e))
          message("Check ", input)
        }
        obj <- tryCatch(
          expr = readRDS(file = input),
          error = function(e2) {
            NULL
          }
        )
        if (is.null(x = obj)) {
          obj <- list()
        }
        attr(x = obj, which = "mx_fit_error") <- conditionMessage(c = e)
        attr(x = obj, which = "mx_fit_error_call") <- conditionCall(c = e)
        attr(x = obj, which = "mx_fit_error_time") <- Sys.time()
        if (length(x = warn_msg) > 0) {
          attr(x = obj, which = "mx_fit_warnings") <- unique(x = warn_msg)
        }
        if (isTRUE(x = save_conditions)) {
          saveRDS(object = obj, file = input)
        }
        obj
      }
    ),
    warning = function(w) {
      warn_msg <<- c(warn_msg, conditionMessage(c = w))
      if (!silent) {
        message("Warning while fitting model: ", conditionMessage(c = w))
        message("Check ", input)
      }
      if (isTRUE(x = muffle_warnings)) {
        invokeRestart(r = "muffleWarning")
      }
    }
  )
  out
}
