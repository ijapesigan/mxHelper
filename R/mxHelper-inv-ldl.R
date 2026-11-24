#' Covariance Matrix from its LDL Parts
#'
#' Rebuilds
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}}
#' from the strictly lower triangular part of \eqn{\boldsymbol{L}}
#' and the unconstrained diagonal of \eqn{\boldsymbol{D}}:
#' the inverse of [MxHelperLDL()].
#' Elements of `s_l` on or above the diagonal are ignored.
#' The result is symmetrized.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param s_l Numeric matrix.
#'   Strictly lower triangular part of \eqn{\boldsymbol{L}}
#'   (the element `s_l` of `LDL`).
#' @param uc_d Numeric vector.
#'   Unconstrained diagonal of \eqn{\boldsymbol{D}},
#'   the inverse softplus of its elements
#'   (the element `uc_d` of `LDL`).
#'
#' @return Returns a symmetric numeric matrix.
#'
#' @examples
#' ldl <- MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#' MxHelperInvLDL(
#'   s_l = ldl$s_l,
#'   uc_d = ldl$uc_d
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperInvLDL <- function(s_l,
                           uc_d) {
  .CheckSquare(
    x = s_l,
    arg = "s_l"
  )
  .CheckNumeric(
    x = uc_d,
    arg = "uc_d"
  )
  .MxHelperInvLDL(
    s_l = s_l,
    uc_d = uc_d
  )
}
