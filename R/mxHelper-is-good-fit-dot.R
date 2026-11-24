#' Is the Fit Good? (Internal)
#'
#' Tests whether a fitted model has a status code in `ok_codes`,
#' a finite fit value (with `require_finite_fit = TRUE`), and a
#' largest absolute gradient below `grad_tol`.
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
                               require_finite_fit = TRUE) {
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
  if (out) {
    grad_raw <- tryCatch(
      expr = {
        x$output$gradient
      },
      error = function(e) {
        NULL
      }
    )
    if (is.numeric(x = grad_raw) && length(x = grad_raw) > 0) {
      max_grad <- suppressWarnings(expr = max(abs(x = grad_raw), na.rm = TRUE))
      out <- is.finite(x = max_grad)
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
    out <- out && is.finite(x = max_grad) && (max_grad < grad_tol)
  }
  out
}
