#' Check a Non-Negative Number or NULL
#'
#' Stops with an error unless `x` is `NULL` or a single finite
#' number of zero or more.
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
#' .CheckNonNegativeOrNull(
#'   x = 1e-4,
#'   arg = "nd_tol"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckNonNegativeOrNull <- function(x,
                                    arg) {
  ok <- is.null(x = x) || (
    is.numeric(x = x) &&
      length(x = x) == 1L &&
      is.finite(x = x) &&
      x >= 0
  )
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(
        fmt = "`%s` must be NULL or a single non-negative number.",
        arg
      ),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
