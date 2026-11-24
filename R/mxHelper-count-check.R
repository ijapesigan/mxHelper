#' Check a Positive Integer
#'
#' Stops with an error unless `x` is a single finite whole number
#' of at least one, such as a number of rows or columns.
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
#' .CheckCount(
#'   x = 2,
#'   arg = "p"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckCount <- function(x,
                        arg) {
  ok <- is.numeric(x = x) &&
    length(x = x) == 1L &&
    is.finite(x = x) &&
    x >= 1 &&
    x == round(x = x)
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(fmt = "`%s` must be a single positive integer.", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
