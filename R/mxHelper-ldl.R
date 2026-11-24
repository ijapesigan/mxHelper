#' LDL Decomposition of a Covariance Matrix
#'
#' Decomposes a symmetric positive definite matrix as
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}},
#' with \eqn{\boldsymbol{L}} unit lower triangular and \eqn{\boldsymbol{D}}
#' diagonal, and returns the parts in the form that
#' [MxHelperSigmaFromLDLMxMatrix()] takes as starting values.
#' A zero on the diagonal of `x` is replaced by `epsilon` first.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric matrix.
#'   Symmetric positive definite matrix
#'   (\eqn{\boldsymbol{\Sigma}}).
#' @param epsilon Positive number.
#'   Value that replaces a zero on the diagonal of `x`.
#'
#' @return Returns a list with the elements
#'   \describe{
#'     \item{l}{Unit lower triangular matrix \eqn{\boldsymbol{L}}.}
#'     \item{s_l}{Strictly lower triangular part of \eqn{\boldsymbol{L}}.}
#'     \item{d}{Diagonal of \eqn{\boldsymbol{D}}.}
#'     \item{uc_d}{Inverse softplus of `d`.}
#'     \item{x}{The input, after the diagonal replacement.}
#'     \item{epsilon}{The value of `epsilon`.}
#'   }
#'
#' @examples
#' MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperLDL <- function(x,
                        epsilon = 1e-10) {
  .CheckSquare(
    x = x,
    arg = "x"
  )
  .CheckPositive(
    x = epsilon,
    arg = "epsilon"
  )
  .MxHelperLDL(
    x = x,
    epsilon = epsilon
  )
}
