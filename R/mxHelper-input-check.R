#' Check an Input File
#'
#' Stops with an error unless `x` is the path of an existing file,
#' such as the `.rds` file of an OpenMx model.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object to check.
#'
#' @return Returns `NULL`, invisibly, when `x` is valid.
#'
#' @examples
#' .CheckInput(
#'   x = system.file(package = "OpenMx")
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckInput <- function(x) {
  ok <- is.character(x = x) &&
    length(x = x) == 1L &&
    !is.na(x = x) &&
    file.exists(x)
  if (!isTRUE(x = ok)) {
    stop(
      "`input` must be the path of an existing file.",
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
