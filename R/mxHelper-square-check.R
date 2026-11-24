#' Check a Square Numeric Matrix
#'
#' Stops with an error unless `x` is a numeric square matrix
#' without missing values.
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
#' .CheckSquare(
#'   x = diag(x = 2),
#'   arg = "x"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckSquare <- function(x,
                         arg) {
  ok <- is.matrix(x = x) &&
    is.numeric(x = x) &&
    nrow(x = x) == ncol(x = x) &&
    nrow(x = x) > 0L &&
    !anyNA(x = x)
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(
        fmt = "`%s` must be a square numeric matrix without NA.",
        arg
      ),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
