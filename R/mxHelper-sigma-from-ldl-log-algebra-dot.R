# nolint start: object_name_linter, object_length_linter.
#' OpenMx Algebra of a Covariance Matrix from LDL Parts (Log) (Internal)
#'
#' Builds the OpenMx algebra
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}},
#' with \eqn{\boldsymbol{L}} the identity plus `sdiag`,
#' and the diagonal of \eqn{\boldsymbol{D}} the robust log of `column`
#' (`mxRobustLog()`) plus \eqn{10^{-8}}.
#' Unlike the softplus version, the diagonal is positive only
#' when `column` is greater than 1.
#' No input checks: see [MxHelperSigmaFromLDLLogAlgebra()].
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
#' .MxHelperSigmaFromLDLLogAlgebra(
#'   sdiag = "sigma_l",
#'   column = "sigma_d",
#'   iden = "sigma_iden",
#'   name = "sigma"
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaFromLDLLogAlgebra <- function(sdiag,
                                            column,
                                            iden,
                                            name) {
  OpenMx::mxAlgebraFromString(
    algString = paste0(
      "(",
      sdiag,
      "+",
      iden,
      ")",
      "%*%",
      "(vec2diag(mxRobustLog(",
      column,
      ") + 1e-8))",
      "%*%",
      "t(",
      sdiag,
      "+",
      iden,
      ")"
    ),
    name = name
  )
}
# nolint end
