#' Fit the Saturated Model
#'
#' Fits the saturated model (means and covariances) to the data
#' by full information maximum likelihood, with
#' `OpenMx::mxTryHard()`.
#' The covariance matrix is
#' \eqn{\boldsymbol{L} \boldsymbol{L}^{\prime}}, with \eqn{\boldsymbol{L}}
#' lower triangular and its diagonal bounded below by
#' \eqn{10^{-6}}; its starting value is the Cholesky factor of the
#' pairwise covariance matrix, made positive definite first.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Data frame or numeric matrix.
#'   Observed variables in columns, with column names.
#'   Missing values are allowed (full information ML).
#' @param ... Further arguments to `OpenMx::mxTryHard()`.
#'
#' @return Returns a fitted OpenMx model named `FIML`, with the matrices
#'   `l`, `mu`, and the algebra `sigma`.
#'
#' @examples
#' set.seed(seed = 42)
#' x <- data.frame(
#'   y1 = rnorm(n = 50),
#'   y2 = rnorm(n = 50)
#' )
#' fit <- MxHelperQuiet(
#'   expr = MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' OpenMx::mxEval(
#'   expression = sigma,
#'   model = fit
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper
#' @export
MxHelperMuSigma <- function(x,
                            ...) {
  .CheckData(
    x = x
  )
  .MxHelperMuSigma(
    x = x,
    ...
  )
}
