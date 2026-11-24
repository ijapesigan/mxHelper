#' Evaluate Quietly
#'
#' Evaluates `expr` and drops its printed output and messages.
#' `OpenMx::mxTryHard()` prints its progress and result even with
#' `silent = TRUE`; this removes both. Warnings are kept.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperQuiet(
#'   expr = {
#'     message("dropped")
#'     1
#'   }
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperQuiet <- function(expr,
                          silent = TRUE) {
  .CheckFlag(
    x = silent,
    arg = "silent"
  )
  .MxHelperQuiet(
    expr = expr,
    silent = silent
  )
}
