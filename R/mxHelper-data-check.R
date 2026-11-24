#' Check a Data Set
#'
#' Stops with an error unless `x` is a data frame or a numeric matrix
#' with named columns and at least two rows.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object to check.
#'
#' @return Returns `NULL`, invisibly, when `x` is valid.
#'
#' @examples
#' .CheckData(
#'   x = data.frame(y1 = c(1, 2, 3), y2 = c(2, 1, 3))
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckData <- function(x) {
  ok <- (
    is.data.frame(x = x) || (is.matrix(x = x) && is.numeric(x = x))
  ) &&
    ncol(x = x) >= 1L &&
    nrow(x = x) >= 2L &&
    !is.null(x = colnames(x = x))
  if (!isTRUE(x = ok)) {
    stop(
      paste(
        "`x` must be a data frame or a numeric matrix",
        "with named columns and at least two rows."
      ),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
