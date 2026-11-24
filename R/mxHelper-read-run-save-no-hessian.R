#' Read, Fit without the Hessian, and Save a Model
#'
#' Reads an OpenMx model from an `.rds` file, fits it without
#' standard errors or the Hessian ([MxHelperRunNoHessian()]), and saves
#' the fit to the same file.
#' Errors and warnings are recorded, not thrown.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param input Character string.
#'   Path of an `.rds` file that holds an OpenMx model.
#'   The fitted model is saved back to the same file.
#' @param tries_explore Positive integer.
#'   Extra tries of the wide and the local search.
#' @param silent Logical.
#'   If `TRUE`, suppress the progress output of OpenMx.
#' @param save_conditions Logical.
#'   If `TRUE`, an error is saved to `input`
#'   as attributes of the object read from it.
#' @param muffle_warnings Logical.
#'   If `TRUE`, warnings are recorded but not shown.
#'
#' @return Returns the fitted model as read back from `input`.
#'   Warnings are in the attribute `mx_fit_warnings`.
#'   On an error, the object in `input` (or an empty list)
#'   with the attributes `mx_fit_error`, `mx_fit_error_call`, and
#'   `mx_fit_error_time`.
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
#' input <- tempfile(fileext = ".rds")
#' saveRDS(object = fit, file = input)
#' fit <- MxHelperQuiet(
#'   expr = MxHelperReadRunSaveNoHessian(
#'     input = input,
#'     tries_explore = 2,
#'     silent = TRUE
#'   )
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperReadRunSaveNoHessian <- function(input,
                                         tries_explore = 1000,
                                         silent = FALSE,
                                         save_conditions = TRUE,
                                         muffle_warnings = TRUE) {
  .CheckInput(
    x = input
  )
  .CheckCount(
    x = tries_explore,
    arg = "tries_explore"
  )
  .CheckFlag(
    x = silent,
    arg = "silent"
  )
  .CheckFlag(
    x = save_conditions,
    arg = "save_conditions"
  )
  .CheckFlag(
    x = muffle_warnings,
    arg = "muffle_warnings"
  )
  .MxHelperReadRunSaveNoHessian(
    input = input,
    tries_explore = tries_explore,
    silent = silent,
    save_conditions = save_conditions,
    muffle_warnings = muffle_warnings
  )
}
