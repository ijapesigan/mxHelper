#' Starting Values of an Intercept Vector
#'
#' Builds the starting values of the `p` by 1 intercept vector
#' of a discrete-time vector autoregressive model.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperDTVARAlphaValues(
#'   p = 2,
#'   val = NULL
#' )
#'
#' @family Starting Values Functions
#' @keywords mxHelper
#' @export
MxHelperDTVARAlphaValues <- function(p,
                                     val) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckVal(
    x = val,
    arg = "val",
    mode = "numeric",
    na = FALSE
  )
  .MxHelperDTVARAlphaValues(
    p = p,
    val = val
  )
}
