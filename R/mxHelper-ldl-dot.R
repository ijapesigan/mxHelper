#' LDL Decomposition of a Covariance Matrix (Internal)
#'
#' Decomposes a symmetric positive definite matrix as
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}},
#' with \eqn{\boldsymbol{L}} unit lower triangular and \eqn{\boldsymbol{D}}
#' diagonal, and returns the parts in the form that
#' `.MxHelperSigmaFromLDLMxMatrix()` takes as starting values.
#' A zero on the diagonal of `x` is replaced by `epsilon` first.
#' No input checks: see [MxHelperLDL()].
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
#' .MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperLDL <- function(x,
                         epsilon = 1e-10) {
  diag(x = x) <- ifelse(
    test = diag(x = x) == 0,
    yes = epsilon,
    no = diag(x = x)
  )
  k <- dim(x = x)[1]
  l <- diag(x = k)
  d <- numeric(length = k)
  for (i in seq_len(length.out = k)) {
    # compute d_mat[i]
    if (i == 1) {
      d[i] <- x[i, i]
    } else {
      s <- 0.0
      for (p in seq_len(length.out = i - 1)) {
        s <- s + l[i, p] * l[i, p] * d[p]
      }
      d[i] <- x[i, i] - s
    }
    if (i < k) {
      for (j in (i + 1):k) {
        s <- 0.0
        if (i > 1) {
          for (p in seq_len(length.out = i - 1)) {
            s <- s + l[j, p] * l[i, p] * d[p]
          }
        }
        l[j, i] <- (x[j, i] - s) / d[i]
      }
    }
  }
  list(
    l = l,
    s_l = l - diag(x = k),
    d = d,
    uc_d = .MxHelperInvSoftplus(x = d),
    x = x,
    epsilon = epsilon
  )
}
