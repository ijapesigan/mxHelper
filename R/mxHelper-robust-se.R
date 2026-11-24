#' Robust Standard Errors
#'
#' Computes robust (sandwich) standard errors of a fitted model
#' with `OpenMx::imxRobustSE()`, quietly.
#' On an error, it returns `NULL`.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`), usually fitted.
#'
#' @return Returns the list of `OpenMx::imxRobustSE()` with
#'   `details = TRUE` (`SE`, `cov`, `bread`, `meat`, `TIC`),
#'   or `NULL`.
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
#' MxHelperRobustSE(
#'   model = fit
#' )$SE
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperRobustSE <- function(model) {
  .CheckMxModel(
    x = model,
    arg = "model"
  )
  .RobustSE(
    model = model
  )
}
