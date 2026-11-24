#' Check a Character String
#'
#' Stops with an error unless `x` is a single character string
#' that is neither missing nor empty, such as the name of a matrix.
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
#' .CheckString(
#'   x = "beta",
#'   arg = "name"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckString <- function(x,
                         arg) {
  ok <- is.character(x = x) &&
    length(x = x) == 1L &&
    !is.na(x = x) &&
    nzchar(x = x)
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(fmt = "`%s` must be a single non-empty character string.", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
