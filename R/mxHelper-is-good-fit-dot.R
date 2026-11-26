#' Is the Fit Good? (Internal)
#'
#' Tests whether a fitted model has a status code in `ok_codes`,
#' a finite fit value (with `require_finite_fit = TRUE`), and a
#' largest absolute gradient below `grad_tol`.
#' A fit that fails the gradient test is still good when its
#' Newton decrement `g' H^{-1} g` is below `nd_tol`
#' (`g` the gradient, `H` the Hessian of the fit, positive definite):
#' half of it is what a Newton step would still gain in the fit value,
#' so the test does not depend on the scale of the parameters.
#' Missing output counts as a bad fit.
#' No input checks: see [MxHelperIsGoodFit()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
#' @param grad_tol Positive number.
#'   Largest absolute gradient of a good fit.
#' @param ok_codes Integer vector.
#'   OpenMx status codes accepted as converged.
#' @param require_finite_fit Logical.
#'   If `TRUE`, a good fit needs a finite fit value.
#' @param nd_tol Non-negative number or `NULL`.
#'   Largest Newton decrement of a good fit, tested only when the
#'   gradient test fails and the fit has a positive definite Hessian.
#'   `NULL` or `0` switches this test off.
#'
#' @return Returns `TRUE` or `FALSE`.
#'   `TRUE` has the attribute `criterion`: `"gradient"` when the fit
#'   passes the gradient test, `"newton"` when it passes only the
#'   Newton decrement test.
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
#' .MxHelperIsGoodFit(
#'   x = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperIsGoodFit <- function(x,
                               grad_tol = 1e-2,
                               ok_codes = 0L,
                               require_finite_fit = TRUE,
                               nd_tol = 1e-4) {
  status_code <- tryCatch(
    expr = {
      x$output$status$code
    },
    error = function(e) {
      NA_integer_
    }
  )
  out <- isTRUE(x = status_code %in% ok_codes)
  if (out && require_finite_fit) {
    fitval <- tryCatch(
      expr = {
        x$output$fit
      },
      error = function(e) {
        NA_real_
      }
    )
    out <- is.finite(x = fitval)
  }
  criterion <- NULL
  if (out) {
    grad_raw <- tryCatch(
      expr = {
        x$output$gradient
      },
      error = function(e) {
        NULL
      }
    )
    has_grad <- is.numeric(x = grad_raw) && length(x = grad_raw) > 0
    if (has_grad) {
      max_grad <- suppressWarnings(expr = max(abs(x = grad_raw), na.rm = TRUE))
    } else {
      # Avoid summary unless needed
      max_grad <- tryCatch(
        expr = {
          as.numeric(x = summary(object = x)$maxAbsGradient)
        },
        error = function(e) {
          NA_real_
        }
      )
    }
    if (isTRUE(x = is.finite(x = max_grad) && (max_grad < grad_tol))) {
      criterion <- "gradient"
    } else if (
      has_grad &&
        isTRUE(x = is.finite(x = max_grad)) &&
        !is.null(x = nd_tol) &&
        nd_tol > 0
    ) {
      # Newton decrement g' H^{-1} g, from the Cholesky factor of H;
      # NA when H is missing, does not match g, or is not positive definite
      nd <- tryCatch(
        expr = {
          hessian <- x$output$hessian
          has_names <- !is.null(x = names(x = grad_raw)) &&
            !is.null(x = rownames(x = hessian)) &&
            !is.null(x = colnames(x = hessian))
          if (has_names) {
            hessian <- hessian[
              names(x = grad_raw),
              names(x = grad_raw),
              drop = FALSE
            ]
          }
          hessian <- 0.5 * (hessian + t(x = hessian))
          chol_h <- chol(x = hessian)
          sum(
            backsolve(
              r = chol_h,
              x = as.numeric(x = grad_raw),
              transpose = TRUE
            )^2
          )
        },
        error = function(e) {
          NA_real_
        }
      )
      if (isTRUE(x = is.finite(x = nd) && (nd < nd_tol))) {
        criterion <- "newton"
      }
    }
    out <- !is.null(x = criterion)
  }
  if (out) {
    attr(x = out, which = "criterion") <- criterion
  }
  out
}
