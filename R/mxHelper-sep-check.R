#' Check a Label Separator
#'
#' Stops with an error unless `x` is `"underscore"` or `"bracket"`,
#' the two separators of the label functions.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object to check.
#'
#' @return Returns `NULL`, invisibly, when `x` is valid.
#'
#' @examples
#' .CheckSep(
#'   x = "bracket"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckSep <- function(x) {
  ok <- is.character(x = x) &&
    length(x = x) == 1L &&
    x %in% c("underscore", "bracket")
  if (!isTRUE(x = ok)) {
    stop(
      "`sep` must be \"underscore\" or \"bracket\".",
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
