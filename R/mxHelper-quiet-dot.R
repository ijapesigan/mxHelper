#' Evaluate Quietly (Internal)
#'
#' Evaluates `expr` and drops its printed output and messages.
#' `OpenMx::mxTryHard()` prints its progress and result even with
#' `silent = TRUE`; this removes both. Warnings are kept.
#' No input checks: see [MxHelperQuiet()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param expr R expression.
#'   Expression to evaluate.
#' @param silent Logical.
#'   If `TRUE`, drop the printed output and the messages
#'   of `expr`; if `FALSE`, evaluate `expr` as it is.
#'
#' @return Returns the value of `expr`.
#'
#' @examples
#' .MxHelperQuiet(
#'   expr = {
#'     message("dropped")
#'     1
#'   }
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperQuiet <- function(expr,
                           silent = TRUE) {
  # with silent = TRUE, mxTryHard() still prints its progress
  # (cat) and its result (message); drop both
  if (isTRUE(x = silent)) {
    out <- NULL
    utils::capture.output(
      out <- suppressMessages(expr = expr)
    )
  } else {
    out <- expr
  }
  out
}
