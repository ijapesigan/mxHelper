#' Turn off the Hessian
#'
#' Turns off standard errors and the Hessian of a model:
#' the option `Standard Errors` is set to `"No"`, and the steps
#' that compute standard errors, the Hessian, or numerical
#' derivatives are removed from the compute plan.
#' A model without a compute plan gets a minimal one
#' (gradient descent, then the fit).
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#'
#' @return Returns the model without standard error or Hessian steps.
#'
#' @examples
#' model <- OpenMx::mxModel(model = "m")
#' model <- MxHelperStripHessian(
#'   model = model
#' )
#' class(x = model@compute)
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperStripHessian <- function(model) {
  .CheckMxModel(
    x = model,
    arg = "model"
  )
  .MxHelperStripHessian(
    model = model
  )
}
