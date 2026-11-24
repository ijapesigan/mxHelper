#' Check a Numeric Vector
#'
#' Stops with an error unless `x` is a non-empty numeric vector
#' or matrix without missing values.
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
#' .CheckNumeric(
#'   x = c(-1, 0, 1),
#'   arg = "x"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckNumeric <- function(x,
                          arg) {
  ok <- is.numeric(x = x) &&
    length(x = x) > 0L &&
    !anyNA(x = x)
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(fmt = "`%s` must be a numeric vector without NA.", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
