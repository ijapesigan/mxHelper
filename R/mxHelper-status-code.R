#' Status Code of a Fitted Model
#'
#' Reads the OpenMx status code of a fitted model.
#' Stops with an error when the model has no single status code,
#' and warns, with the status details, when the code is not 0.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param context Character string.
#'   Name of the model in the messages.
#'   By default, the expression passed as `model`.
#'
#' @return Returns the status code; the internal version returns it
#'   invisibly.
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
#' MxHelperStatusCode(
#'   model = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper
#' @export
MxHelperStatusCode <- function(model,
                               context = deparse(
                                 expr = substitute(expr = model)
                               )) {
  .CheckMxModel(
    x = model,
    arg = "model"
  )
  .CheckString(
    x = context,
    arg = "context"
  )
  code <- .CheckStatusCode(
    model = model,
    context = context
  )
  code
}
