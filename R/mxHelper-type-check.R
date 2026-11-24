#' Check a Covariance Type
#'
#' Stops with an error unless `x` is `NULL`,
#' `"zero"`, `"identity"`, or `"diffused"`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object to check.
#'
#' @return Returns `NULL`, invisibly, when `x` is valid.
#'
#' @examples
#' .CheckType(
#'   x = "identity"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckType <- function(x) {
  ok <- is.null(x = x) || (
    is.character(x = x) &&
      length(x = x) == 1L &&
      x %in% c("zero", "identity", "diffused")
  )
  if (!isTRUE(x = ok)) {
    stop(
      "`type` must be NULL, \"zero\", \"identity\", or \"diffused\".",
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
