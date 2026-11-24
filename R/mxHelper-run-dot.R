#' Fit a Model Unless It Is Already Good (Internal)
#'
#' Fits the model with `OpenMx::mxTryHard()`, accepting status
#' codes 0, 1, 5, and 6, unless it is already a good fit
#' (`.MxHelperIsGoodFit()`) with a positive definite Hessian
#' (`.MxHelperHasPdHessian()`).
#' On an error, the input model is returned.
#' No input checks: see [MxHelperRun()].
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
#' @param silent Logical.
#'   If `TRUE`, suppress the progress output of OpenMx.
#' @param ... Further arguments to `OpenMx::mxTryHard()`.
#'
#' @return Returns an OpenMx model.
#'   The internal version returns `NULL` when `model` is not an
#'   OpenMx model.
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
#' fit <- .MxHelperRun(
#'   model = fit
#' )
#' fit$output$status$code
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperRun <- function(model,
                         grad_tol = 1e-2,
                         ok_codes = 0L,
                         require_finite_fit = TRUE,
                         hess_tol_abs = 1e-8,
                         hess_tol_rel = 1e-10,
                         check_condition = FALSE,
                         cond_max = 1e12,
                         silent = FALSE,
                         ...) {
  out <- NULL
  if (inherits(x = model, what = "MxModel")) {
    # Default: rerun unless we can prove it's already "good"
    run <- TRUE
    has_status <- (
      !is.null(x = model$output) &&
        !is.null(x = model$output$status) &&
        !is.null(x = model$output$status$code)
    )
    if (has_status && model$output$status$code == 0L) {
      good_fit <- tryCatch(
        expr = .MxHelperIsGoodFit(
          x = model,
          grad_tol = grad_tol,
          ok_codes = ok_codes,
          require_finite_fit = require_finite_fit
        ),
        error = function(e) {
          FALSE
        }
      )
      if (isTRUE(x = good_fit)) {
        pd_hessian <- tryCatch(
          expr = .MxHelperHasPdHessian(
            x = model,
            hess_tol_abs = hess_tol_abs,
            hess_tol_rel = hess_tol_rel,
            check_condition = check_condition,
            cond_max = cond_max
          ),
          error = function(e) {
            FALSE
          }
        )
        run <- isFALSE(x = pd_hessian)
      } else {
        run <- TRUE
      }
    }
    input_model <- model
    if (run) {
      # allow status codes 0, 1, 5, 6
      model <- tryCatch(
        expr = .MxHelperQuiet(
          expr = OpenMx::mxTryHard(
            model = model,
            silent = silent,
            OKstatuscodes = c(0, 1, 5, 6),
            ...
          ),
          silent = silent
        ),
        error = function(e) {
          input_model
        }
      )
    }
    out <- model
  }
  out
}
