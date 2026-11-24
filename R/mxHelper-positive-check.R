#' Check a Positive Number
#'
#' Stops with an error unless `x` is a single finite number
#' greater than zero, such as a tolerance.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object to check.
#' @param arg Character string.
#'   Name of the argument, for the error message.
#'
#' @return Returns `NULL`, invisibly, when `x` is valid.
#'
#' @examples
#' .CheckPositive(
#'   x = 1e-6,
#'   arg = "abs_bnd_tol"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckPositive <- function(x,
                           arg) {
  ok <- is.numeric(x = x) &&
    length(x = x) == 1L &&
    is.finite(x = x) &&
    x > 0
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(fmt = "`%s` must be a single positive number.", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
