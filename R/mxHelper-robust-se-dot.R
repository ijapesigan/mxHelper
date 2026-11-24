#' Robust Standard Errors (Internal)
#'
#' Computes robust (sandwich) standard errors of a fitted model
#' with `OpenMx::imxRobustSE()`, quietly.
#' On an error, it returns `NULL`.
#' No input checks: see [MxHelperRobustSE()].
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
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' .RobustSE(
#'   model = fit
#' )$SE
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.RobustSE <- function(model) {
  out <- NULL
  if (inherits(x = model, what = "MxModel")) {
    tryCatch(
      expr = utils::capture.output(
        suppressMessages(
          expr = suppressWarnings(
            expr = out <- OpenMx::imxRobustSE(
              model = model,
              details = TRUE
            )
          )
        )
      ),
      error = function(e) {
        NULL
      }
    )
  }
  out
}
