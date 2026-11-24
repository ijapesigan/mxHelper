# nolint start: object_name_linter, object_length_linter.
#' OpenMx Algebra of a Covariance Matrix from LDL Parts
#'
#' The covariance matrix is
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}},
#' with \eqn{\boldsymbol{L}} unit lower triangular and \eqn{\boldsymbol{D}}
#' diagonal; the diagonal of \eqn{\boldsymbol{D}} is the softplus
#' of an unconstrained vector, so \eqn{\boldsymbol{\Sigma}} stays
#' positive definite.
#' This function builds that algebra, with a softplus written
#' in OpenMx algebra and \eqn{10^{-8}} added to the diagonal
#' of \eqn{\boldsymbol{D}}.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param sdiag Character string.
#'   Name of the strictly lower triangular matrix
#'   \eqn{\boldsymbol{L}} minus the identity.
#' @param column Character string.
#'   Name of the column vector of unconstrained diagonal elements
#'   of \eqn{\boldsymbol{D}}.
#' @param iden Character string.
#'   Name of the identity matrix.
#' @param name Character string.
#'   Name of the matrix or algebra.
#'
#' @return Returns an OpenMx algebra (`MxAlgebra`) named `name`.
#'
#' @examples
#' MxHelperSigmaFromLDLSoftplusAlgebra(
#'   sdiag = "sigma_l",
#'   column = "sigma_d",
#'   iden = "sigma_iden",
#'   name = "sigma"
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSigmaFromLDLSoftplusAlgebra <- function(sdiag,
                                                column,
                                                iden,
                                                name) {
  .CheckString(
    x = sdiag,
    arg = "sdiag"
  )
  .CheckString(
    x = column,
    arg = "column"
  )
  .CheckString(
    x = iden,
    arg = "iden"
  )
  .CheckString(
    x = name,
    arg = "name"
  )
  .MxHelperSigmaFromLDLSoftplusAlgebra(
    sdiag = sdiag,
    column = column,
    iden = iden,
    name = name
  )
}
# nolint end
