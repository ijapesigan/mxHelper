#' Turn on the Hessian
#'
#' Sets the OpenMx options `Calculate Hessian` and `Hessian` of
#' the model to `"Yes"`, so that a fit computes the Hessian.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#'
#' @return Returns the model with the two options set.
#'
#' @examples
#' model <- OpenMx::mxModel(model = "m")
#' model <- MxHelperForceHessianOptions(
#'   model = model
#' )
#' model@options
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperForceHessianOptions <- function(model) {
  .CheckMxModel(
    x = model,
    arg = "model"
  )
  .MxHelperForceHessianOptions(
    model = model
  )
}
