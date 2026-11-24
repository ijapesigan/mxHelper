#' Turn off the Hessian (Internal)
#'
#' Turns off standard errors and the Hessian of a model:
#' the option `Standard Errors` is set to `"No"`, and the steps
#' that compute standard errors, the Hessian, or numerical
#' derivatives are removed from the compute plan.
#' A model without a compute plan gets a minimal one
#' (gradient descent, then the fit).
#' No input checks: see [MxHelperStripHessian()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#'
#' @return Returns the model without standard error or Hessian steps.
#'
#' @examples
#' model <- OpenMx::mxModel(model = "m")
#' model <- .MxHelperStripHessian(
#'   model = model
#' )
#' class(x = model@compute)
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperStripHessian <- function(model) {
  mod <- model
  cp <- mod@compute

  # If there's no compute plan, build a minimal one (no SE/Hessian)
  if (is.null(x = cp)) {
    mod <- OpenMx::mxModel(
      model = mod,
      OpenMx::mxComputeSequence(
        steps = list(
          OpenMx::mxComputeGradientDescent(),
          OpenMx::mxComputeOnce(from = "fitfunction", what = "fit")
        )
      )
    )
    mod <- OpenMx::mxOption(
      model = mod,
      key   = "Standard Errors",
      value = "No"
    )
  } else {
    # Disable SEs at the option level
    mod <- OpenMx::mxOption(
      model = mod,
      key   = "Standard Errors",
      value = "No"
    )
    # If there is a plan, strip any SE/Hessian steps from the sequence
    if (inherits(x = cp, what = "MxComputeSequence") && length(x = cp$steps)) {
      keep <- vapply(
        X = cp$steps,
        FUN.VALUE = logical(length = 1),
        FUN = function(st) {
          !inherits(x = st, what = "MxComputeStandardError") &&
            !inherits(x = st, what = "MxComputeHessianQuality") &&
            !inherits(x = st, what = "MxComputeNumericDeriv")
        }
      )
      new_steps <- cp$steps[keep]
      if (!length(x = new_steps)) {
        new_steps <- list(
          OpenMx::mxComputeGradientDescent(),
          OpenMx::mxComputeOnce(from = "fitfunction", what = "fit")
        )
      }
      mod <- OpenMx::mxModel(
        model = mod,
        OpenMx::mxComputeSequence(steps = new_steps)
      )
      mod <- OpenMx::mxOption(
        model = mod,
        key   = "Standard Errors",
        value = "No"
      )
    }
  }

  mod
}
