#' Covariance Matrix from its LDL Parts (Internal)
#'
#' Rebuilds
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}}
#' from the strictly lower triangular part of \eqn{\boldsymbol{L}}
#' and the unconstrained diagonal of \eqn{\boldsymbol{D}}:
#' the inverse of `.MxHelperLDL()`.
#' Elements of `s_l` on or above the diagonal are ignored.
#' The result is symmetrized.
#' No input checks: see [MxHelperInvLDL()].
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
#' ldl <- .MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#' .MxHelperInvLDL(
#'   s_l = ldl$s_l,
#'   uc_d = ldl$uc_d
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperInvLDL <- function(s_l,
                            uc_d) {
  iden <- d <- diag(x = dim(x = s_l)[1])
  s_l[
    upper.tri(
      x = s_l,
      diag = TRUE
    )
  ] <- 0
  l <- s_l + iden
  diag(x = d) <- .MxHelperSoftplus(x = c(uc_d))
  sigma <- l %*% d %*% t(x = l)
  0.5 * (sigma + t(x = sigma))
}
