#' Is the Fit Good?
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
                              require_finite_fit = TRUE,
                              nd_tol = 1e-4) {
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
  .CheckNonNegativeOrNull(
    x = nd_tol,
    arg = "nd_tol"
  )
  .MxHelperIsGoodFit(
    x = x,
    grad_tol = grad_tol,
    ok_codes = ok_codes,
    require_finite_fit = require_finite_fit,
    nd_tol = nd_tol
  )
}
