#' Fixed Covariance Matrix from LDL Parts
#'
#' Builds a covariance matrix with no free elements from the
#' strictly lower triangular part of \eqn{\boldsymbol{L}} and the
#' unconstrained diagonal of \eqn{\boldsymbol{D}},
#' as [MxHelperSigmaFromLDLMxMatrix()] does.
#' The matrices are named `<name>_l` and `<name>_d`;
#' the model must hold the identity matrix `iden_name`.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param d_values Numeric vector.
#'   Unconstrained diagonal of \eqn{\boldsymbol{D}}
#'   (the element `uc_d` of `LDL`).
#' @param l_values Numeric matrix.
#'   Strictly lower triangular part of \eqn{\boldsymbol{L}}
#'   (the element `s_l` of `LDL`).
#' @param row Character vector or `NULL`.
#'   Names of the variables (rows and columns).
#' @param name Character string.
#'   Name of the matrix or algebra.
#' @param iden_name Character string or `NULL`.
#'   Name of the identity matrix, which the model must hold.
#'   If `NULL`, `<name>_iden`.
#'
#' @return Returns a named list of OpenMx matrices and algebras.
#'
#' @examples
#' ldl <- MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#' MxHelperSigmaFromLDLFixed(
#'   p = 2,
#'   d_values = ldl$uc_d,
#'   l_values = ldl$s_l,
#'   row = c("y1", "y2"),
#'   name = "sigma",
#'   iden_name = NULL
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSigmaFromLDLFixed <- function(p,
                                      d_values,
                                      l_values,
                                      row,
                                      name,
                                      iden_name) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckNumeric(
    x = d_values,
    arg = "d_values"
  )
  .CheckSquare(
    x = l_values,
    arg = "l_values"
  )
  .CheckLabels(
    x = row,
    arg = "row"
  )
  .CheckString(
    x = name,
    arg = "name"
  )
  if (!is.null(x = iden_name)) {
    .CheckString(
      x = iden_name,
      arg = "iden_name"
    )
  }
  .MxHelperSigmaFromLDLFixed(
    p = p,
    d_values = d_values,
    l_values = l_values,
    row = row,
    name = name,
    iden_name = iden_name
  )
}
