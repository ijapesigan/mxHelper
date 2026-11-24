#' Is the Hessian Positive Definite? (Internal)
#'
#' Tests whether the Hessian of a fitted model is positive
#' definite: its smallest eigenvalue exceeds
#' \eqn{\tau_{\mathrm{abs}} + \tau_{\mathrm{rel}}
#' \max \left( 1, \max_{i} \left| \lambda_{i} \right| \right)}.
#' With `check_condition = TRUE`, its condition number must also
#' be at most `cond_max`. A missing Hessian counts as not
#' positive definite.
#' No input checks: see [MxHelperHasPdHessian()].
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
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' .MxHelperHasPdHessian(
#'   x = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperHasPdHessian <- function(x,
                                  hess_tol_abs = 1e-8,
                                  hess_tol_rel = 1e-10,
                                  check_condition = FALSE,
                                  cond_max = 1e12) {
  hessian <- x$output$hessian
  if (is.null(x = hessian) || !is.matrix(x = hessian) || anyNA(x = hessian)) {
    out <- FALSE
  } else {
    hessian <- 0.5 * (hessian + t(x = hessian))
    eig <- tryCatch(
      expr = eigen(
        x = hessian,
        symmetric = TRUE,
        only.values = TRUE
      )$values,
      error = function(e) {
        NA_real_
      }
    )
    if (
      !is.numeric(x = eig) ||
        length(x = eig) == 0L ||
        !all(is.finite(x = eig))
    ) {
      out <- FALSE
    } else {
      scale <- max(1, max(abs(x = eig)))
      thresh <- hess_tol_abs + hess_tol_rel * scale
      out <- min(eig) > thresh
      if (out && check_condition) {
        # Condition number approx: max/min eigenvalue for symmetric PD matrix
        cond <- max(eig) / min(eig)
        if (!is.finite(x = cond) || cond > cond_max) {
          out <- FALSE
        }
      }
    }
  }
  out
}
