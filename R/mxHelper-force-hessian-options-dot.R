#' Turn on the Hessian (Internal)
#'
#' Sets the OpenMx options `Calculate Hessian` and `Hessian` of
#' the model to `"Yes"`, so that a fit computes the Hessian.
#' No input checks: see [MxHelperForceHessianOptions()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#'
#' @return Returns the model with the two options set.
#'
#' @examples
#' model <- OpenMx::mxModel(model = "m")
#' model <- .MxHelperForceHessianOptions(
#'   model = model
#' )
#' model@options
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperForceHessianOptions <- function(model) {
  model <- OpenMx::mxOption(
    model = model,
    key = "Calculate Hessian",
    value = "Yes"
  )
  model <- OpenMx::mxOption(
    model = model,
    key = "Hessian",
    value = "Yes"
  )
  model
}
