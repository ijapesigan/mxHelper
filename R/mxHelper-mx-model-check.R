#' Check an OpenMx Model
#'
#' Stops with an error unless `x` is an OpenMx model
#' (an object of class `MxModel`).
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
#' .CheckMxModel(
#'   x = OpenMx::mxModel(model = "m"),
#'   arg = "model"
#' )
#'
#' @family Check Functions
#' @keywords mxHelper check internal
#' @noRd
.CheckMxModel <- function(x,
                          arg) {
  if (!inherits(x = x, what = "MxModel")) {
    stop(
      sprintf(fmt = "`%s` must be an OpenMx model (`MxModel`).", arg),
      call. = FALSE
    )
  }
  invisible(x = NULL)
}
