#' Starting Values of an Intercept Vector (Internal)
#'
#' Builds the starting values of the `p` by 1 intercept vector
#' of a discrete-time vector autoregressive model.
#' No input checks: see [MxHelperDTVARAlphaValues()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param val Numeric vector or matrix, or `NULL`.
#'   Intercept column vector. If `NULL`, zeros.
#'
#' @return Returns a `p` by 1 numeric matrix.
#'
#' @examples
#' .MxHelperDTVARAlphaValues(
#'   p = 2,
#'   val = NULL
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperDTVARAlphaValues <- function(p,
                                      val) {
  if (is.null(x = val)) {
    val <- matrix(
      data = 0,
      nrow = p,
      ncol = 1
    )
  } else {
    if (is.vector(x = val)) {
      val <- matrix(
        data = val,
        nrow = p,
        ncol = 1
      )
    }
    stopifnot(
      is.matrix(x = val),
      dim(x = val) == c(p, 1)
    )
  }
  val
}
