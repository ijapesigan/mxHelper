#' Read, Fit without the Hessian, and Save a Model (Internal)
#'
#' Reads an OpenMx model from an `.rds` file, fits it without
#' standard errors or the Hessian (`.MxHelperRunNoHessian()`), and saves
#' the fit to the same file.
#' Errors and warnings are recorded, not thrown.
#' No input checks: see [MxHelperReadRunSaveNoHessian()].
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
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' input <- tempfile(fileext = ".rds")
#' saveRDS(object = fit, file = input)
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperReadRunSaveNoHessian(
#'     input = input,
#'     tries_explore = 2,
#'     silent = TRUE
#'   )
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperReadRunSaveNoHessian <- function(input,
                                          tries_explore = 1000,
                                          silent = FALSE,
                                          save_conditions = TRUE,
                                          muffle_warnings = TRUE) {
  warn_msg <- character(length = 0)
  out <- withCallingHandlers(
    expr = tryCatch(
      expr = {
        model <- readRDS(file = input)
        fit <- .MxHelperRunNoHessian(
          model = model,
          tries_explore = tries_explore,
          silent = silent
        )
        if (length(x = warn_msg) > 0) {
          attr(x = fit, which = "mx_fit_warnings") <- unique(x = warn_msg)
        }
        saveRDS(object = fit, file = input)
        readRDS(file = input)
      },
      error = function(e) {
        if (!silent) {
          message("Error while fitting model: ", conditionMessage(c = e))
          message("Check ", input)
        }
        obj <- tryCatch(
          expr = readRDS(file = input),
          error = function(e2) {
            NULL
          }
        )
        if (is.null(x = obj)) {
          obj <- list()
        }
        attr(x = obj, which = "mx_fit_error") <- conditionMessage(c = e)
        attr(x = obj, which = "mx_fit_error_call") <- conditionCall(c = e)
        attr(x = obj, which = "mx_fit_error_time") <- Sys.time()
        if (length(x = warn_msg) > 0) {
          attr(x = obj, which = "mx_fit_warnings") <- unique(x = warn_msg)
        }
        if (isTRUE(x = save_conditions)) {
          saveRDS(object = obj, file = input)
        }
        obj
      }
    ),
    warning = function(w) {
      warn_msg <<- c(warn_msg, conditionMessage(c = w))
      if (!silent) {
        message("Warning while fitting model: ", conditionMessage(c = w))
        message("Check ", input)
      }
      if (isTRUE(x = muffle_warnings)) {
        invokeRestart(r = "muffleWarning")
      }
    }
  )
  out
}
