#' Check a Logical Flag
#'
#' Stops with an error unless `x` is a single `TRUE` or `FALSE`.
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
#' .CheckFlag(
#'   x = TRUE,
#'   arg = "vec"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckFlag <- function(x,
                       arg) {
  ok <- is.logical(x = x) &&
    length(x = x) == 1L &&
    !is.na(x = x)
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(fmt = "`%s` must be a single TRUE or FALSE.", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
