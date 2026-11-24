#' Check Matrix Values
#'
#' Stops with an error unless `x` is `NULL`,
#' or a vector or matrix of the given mode.
#' With `na = TRUE`, `x` may also be all `NA` (no bounds).
#' The functions that use `x` check its dimensions.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object to check.
#' @param arg Character string.
#'   Name of the argument, for the error message.
#' @param mode Character string.
#'   `"numeric"` or `"logical"`.
#' @param na Logical.
#'   If `TRUE`, missing values are allowed (bounds).
#'
#' @return Returns `NULL`, invisibly, when `x` is valid.
#'
#' @examples
#' .CheckVal(
#'   x = c(0.5, 0, 0, 0.5),
#'   arg = "values",
#'   mode = "numeric",
#'   na = FALSE
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckVal <- function(x,
                      arg,
                      mode,
                      na) {
  ok <- is.null(x = x) || (na && all(is.na(x = x))) || (
    (is.vector(x = x) || is.matrix(x = x)) &&
      length(x = x) > 0L &&
      (
        (mode == "numeric" && is.numeric(x = x)) ||
          (mode == "logical" && is.logical(x = x))
      ) &&
      (na || !anyNA(x = x))
  )
  if (!isTRUE(x = ok)) {
    stop(
      sprintf(
        fmt = "`%s` must be NULL, or a %s vector or matrix.",
        arg,
        mode
      ),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
