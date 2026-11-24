#' Is the Fit Good?
#'
#' Tests whether a fitted model has a status code in `ok_codes`,
#' a finite fit value (with `require_finite_fit = TRUE`), and a
#' largest absolute gradient below `grad_tol`.
#' Missing output counts as a bad fit.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' fit <- MxHelperQuiet(
#'   expr = MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' MxHelperIsGoodFit(
#'   x = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper
#' @export
MxHelperIsGoodFit <- function(x,
                              grad_tol = 1e-2,
                              ok_codes = 0L,
                              require_finite_fit = TRUE) {
  .CheckMxModel(
    x = x,
    arg = "x"
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
  .MxHelperIsGoodFit(
    x = x,
    grad_tol = grad_tol,
    ok_codes = ok_codes,
    require_finite_fit = require_finite_fit
  )
}
