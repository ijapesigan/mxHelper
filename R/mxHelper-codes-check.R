#' Check OpenMx Status Codes
#'
#' Stops with an error unless `x` is a non-empty vector of whole numbers
#' without missing values, such as the accepted OpenMx status codes.
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
#' .CheckCodes(
#'   x = c(0L, 1L),
#'   arg = "ok_codes"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckCodes <- function(x,
                        arg) {
  ok <- is.numeric(x = x) &&
    length(x = x) > 0L &&
    all(is.finite(x = x)) &&
    all(x == round(x = x))
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(fmt = "`%s` must be a vector of whole numbers.", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
