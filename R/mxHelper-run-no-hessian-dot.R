#' Fit a Model without the Hessian (Internal)
#'
#' Fits the model without standard errors or the Hessian
#' (`.MxHelperStripHessian()`): a wide search
#' (`OpenMx::mxTryHardWideSearch()`), then a local search
#' (`OpenMx::mxTryHard()`) with normal jitter of scale 0.05,
#' each with `tries_explore` extra tries.
#' No input checks: see [MxHelperRunNoHessian()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param tries_explore Positive integer.
#'   Extra tries of the wide and the local search.
#' @param silent Logical.
#'   If `TRUE`, suppress the progress output of OpenMx.
#'
#' @return Returns the fitted OpenMx model.
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
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperRunNoHessian(
#'     model = fit,
#'     tries_explore = 2,
#'     silent = TRUE
#'   )
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperRunNoHessian <- function(model,
                                  tries_explore,
                                  silent) {
  fit <- OpenMx::mxTryHardWideSearch(
    model = .MxHelperStripHessian(model = model),
    extraTries = tries_explore,
    checkHess = FALSE,
    silent = silent
  )
  fit <- OpenMx::mxTryHard(
    model = fit,
    extraTries = tries_explore,
    silent = silent,
    jitterDistrib = "rnorm",
    scale = 0.05,
    checkHess = FALSE
  )
  fit
}
