# nolint start: object_name_linter, object_length_linter.
#' OpenMx Algebra of a Diagonal Covariance Matrix (Internal)
#'
#' Builds the OpenMx algebra of a diagonal covariance matrix
#' whose diagonal is the softplus of the column vector `column`,
#' plus \eqn{10^{-8}}, so that it stays positive.
#' No input checks: see [MxHelperSigmaDiagFromLDLSoftplusAlgebra()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param column Character string.
#'   Name of the column vector of unconstrained diagonal elements
#'   of \eqn{\boldsymbol{D}}.
#' @param name Character string.
#'   Name of the matrix or algebra.
#'
#' @return Returns an OpenMx algebra (`MxAlgebra`) named `name`.
#'
#' @examples
#' .MxHelperSigmaDiagFromLDLSoftplusAlgebra(
#'   column = "sigma_d",
#'   name = "sigma"
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaDiagFromLDLSoftplusAlgebra <- function(column,
                                                     name) {
  OpenMx::mxAlgebraFromString(
    algString = paste0(
      "vec2diag(",
      "((",
      column,
      " + abs(",
      column,
      ")) / 2) + ",
      "mxRobustLog(1 + exp(-abs(",
      column,
      ")))",
      " + 1e-8",
      ")"
    ),
    name = name
  )
}
# nolint end
