#' Check Optional Labels
#'
#' Stops with an error unless `x` is `NULL`
#' or a character vector without missing values,
#' such as row names or parameter labels.
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
#' .CheckLabels(
#'   x = c("y1", "y2"),
#'   arg = "row"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckLabels <- function(x,
                         arg) {
  ok <- is.null(x = x) || (
    is.character(x = x) && !anyNA(x = x)
  )
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(
        fmt = "`%s` must be NULL or a character vector without NA.",
        arg
      ),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
