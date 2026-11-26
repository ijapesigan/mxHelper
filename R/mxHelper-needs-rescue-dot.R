#' Does the Fit Need a Rescue? (Internal)
#'
#' Tests whether a model needs another fit: its status code is
#' missing or not in `ok_codes`, it is not a good fit
#' (`.MxHelperIsGoodFit()`), its Hessian is not positive definite
#' (`.MxHelperHasPdHessian()`), or an estimate is at an actionable bound
#' (`.MxHelperAtBounds()`). When a test fails with an error, the answer
#' is `TRUE`.
#' No input checks: see [MxHelperNeedsRescue()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param grad_tol Positive number.
#'   Largest absolute gradient of a good fit.
#' @param nd_tol Non-negative number or `NULL`.
#'   Largest Newton decrement of a good fit: a fit that fails
#'   `grad_tol` is still good when `g' H^{-1} g < nd_tol`, with `g`
#'   the gradient and `H` the Hessian (positive definite) of the fit.
#'   `NULL` or `0` switches this test off.
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
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' .MxHelperNeedsRescue(
#'   model = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperNeedsRescue <- function(model,
                                 grad_tol = 1e-2,
                                 nd_tol = 1e-4,
                                 ok_codes = 0L,
                                 require_finite_fit = TRUE,
                                 hess_tol_abs = 1e-8,
                                 hess_tol_rel = 1e-10,
                                 check_condition = TRUE,
                                 cond_max = 1e12,
                                 abs_bnd_tol = 1e-6,
                                 rel_bnd_tol = 1e-4,
                                 allowed_bounds = NULL) {
  # Default: rescue; each check that passes moves on to the next one.
  out <- TRUE
  if (inherits(x = model, what = "MxModel")) {
    bad_status <- (
      is.null(x = model$output) ||
        is.null(x = model$output$status) ||
        is.null(x = model$output$status$code) ||
        is.na(x = model$output$status$code) ||
        !(model$output$status$code %in% ok_codes)
    )
    good_fit <- FALSE
    if (!isTRUE(x = bad_status)) {
      good_fit <- tryCatch(
        expr = .MxHelperIsGoodFit(
          x = model,
          grad_tol = grad_tol,
          nd_tol = nd_tol,
          ok_codes = ok_codes,
          require_finite_fit = require_finite_fit
        ),
        error = function(e) {
          FALSE
        }
      )
    }
    pd_hessian <- FALSE
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
    }
    if (isTRUE(x = pd_hessian)) {
      bd <- tryCatch(
        expr = .MxHelperAtBounds(
          x = model,
          abs_bnd_tol = abs_bnd_tol,
          rel_bnd_tol = rel_bnd_tol,
          allowed_bounds = allowed_bounds
        ),
        error = function(e) {
          NULL
        }
      )
      # If bound assessment fails, be conservative.
      if (!is.null(x = bd)) {
        out <- isTRUE(x = bd$actionable)
      }
    }
  }
  out
}
