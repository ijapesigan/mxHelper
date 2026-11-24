# nolint start: object_name_linter, object_length_linter.
#' OpenMx Matrices of a Covariance Matrix from LDL Parts
#'
#' The covariance matrix is
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}},
#' with \eqn{\boldsymbol{L}} unit lower triangular and \eqn{\boldsymbol{D}}
#' diagonal; the diagonal of \eqn{\boldsymbol{D}} is the softplus
#' of an unconstrained vector, so \eqn{\boldsymbol{\Sigma}} stays
#' positive definite.
#' This function builds the OpenMx matrices and algebras:
#' \eqn{\boldsymbol{L}} below the diagonal (`sdiag_name`),
#' the unconstrained diagonal of \eqn{\boldsymbol{D}} (`column_name`),
#' the identity (when `iden_name = NULL`),
#' \eqn{\boldsymbol{\Sigma}} (`name`), its half-vectorization
#' (`<name>_vech`), and a column vector of the free elements
#' (`<name>_vec`).
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param name Character string.
#'   Name of the matrix or algebra.
#' @param column_name Character string.
#'   Name of the column vector of unconstrained diagonal
#'   elements of \eqn{\boldsymbol{D}}.
#' @param sdiag_name Character string.
#'   Name of the strictly lower triangular matrix of
#'   \eqn{\boldsymbol{L}}.
#' @param iden_name Character string or `NULL`.
#'   Name of the identity matrix.
#'   If `NULL`, the function adds one named `<name>_iden`;
#'   otherwise the model must hold it.
#' @param d_free Logical vector or `NULL`.
#'   Which diagonal elements are free. `NULL` means all.
#' @param d_values Numeric vector, matrix, or `NULL`.
#'   Starting values of the unconstrained diagonal elements:
#'   a vector of length `p`, a `p` by 1 matrix, or a
#'   `p` by `p` matrix whose diagonal is used.
#'   If `NULL`, the inverse softplus of 1.
#' @param d_lbound Numeric vector or `NULL`.
#'   Lower bounds of the unconstrained diagonal elements.
#' @param d_ubound Numeric vector or `NULL`.
#'   Upper bounds of the unconstrained diagonal elements.
#' @param d_rows Character vector or `NULL`.
#'   Row names of the column vector.
#' @param d_cols Character vector or `NULL`.
#'   Column name of the column vector.
#' @param d_equal Logical.
#'   If `TRUE`, the free diagonal elements share one label
#'   (`<column_name>_eq`), so they are equal.
#' @param l_free Logical vector or matrix, or `NULL`.
#'   Which elements of \eqn{\boldsymbol{L}} below the diagonal are
#'   free. `NULL` means all.
#' @param l_values Numeric vector or matrix, or `NULL`.
#'   Starting values of \eqn{\boldsymbol{L}} below the diagonal.
#'   `NULL` means zeros.
#' @param l_lbound Numeric vector or matrix, or `NULL`.
#'   Lower bounds of \eqn{\boldsymbol{L}} below the diagonal.
#' @param l_ubound Numeric vector or matrix, or `NULL`.
#'   Upper bounds of \eqn{\boldsymbol{L}} below the diagonal.
#' @param l_rows Character vector or `NULL`.
#'   Row names of \eqn{\boldsymbol{L}}.
#' @param l_cols Character vector or `NULL`.
#'   Column names of \eqn{\boldsymbol{L}}.
#'
#' @return Returns a named list of OpenMx matrices and algebras.
#'
#' @examples
#' ldl <- MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#' MxHelperSigmaFromLDLMxMatrix(
#'   p = 2,
#'   name = "sigma",
#'   column_name = "sigma_d",
#'   sdiag_name = "sigma_l",
#'   iden_name = NULL,
#'   d_free = TRUE,
#'   d_values = ldl$uc_d,
#'   d_lbound = NA,
#'   d_ubound = NA,
#'   d_rows = NULL,
#'   d_cols = NULL,
#'   d_equal = FALSE,
#'   l_free = TRUE,
#'   l_values = ldl$s_l,
#'   l_lbound = NA,
#'   l_ubound = NA,
#'   l_rows = NULL,
#'   l_cols = NULL
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSigmaFromLDLMxMatrix <- function(p,
                                         name,
                                         column_name,
                                         sdiag_name,
                                         iden_name,
                                         d_free,
                                         d_values,
                                         d_lbound,
                                         d_ubound,
                                         d_rows,
                                         d_cols,
                                         d_equal,
                                         l_free,
                                         l_values,
                                         l_lbound,
                                         l_ubound,
                                         l_rows,
                                         l_cols) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckString(
    x = name,
    arg = "name"
  )
  .CheckString(
    x = column_name,
    arg = "column_name"
  )
  .CheckString(
    x = sdiag_name,
    arg = "sdiag_name"
  )
  if (!is.null(x = iden_name)) {
    .CheckString(
      x = iden_name,
      arg = "iden_name"
    )
  }
  .CheckVal(
    x = d_free,
    arg = "d_free",
    mode = "logical",
    na = FALSE
  )
  .CheckVal(
    x = d_values,
    arg = "d_values",
    mode = "numeric",
    na = FALSE
  )
  .CheckVal(
    x = d_lbound,
    arg = "d_lbound",
    mode = "numeric",
    na = TRUE
  )
  .CheckVal(
    x = d_ubound,
    arg = "d_ubound",
    mode = "numeric",
    na = TRUE
  )
  .CheckLabels(
    x = d_rows,
    arg = "d_rows"
  )
  .CheckLabels(
    x = d_cols,
    arg = "d_cols"
  )
  .CheckFlag(
    x = d_equal,
    arg = "d_equal"
  )
  .CheckVal(
    x = l_free,
    arg = "l_free",
    mode = "logical",
    na = FALSE
  )
  .CheckVal(
    x = l_values,
    arg = "l_values",
    mode = "numeric",
    na = FALSE
  )
  .CheckVal(
    x = l_lbound,
    arg = "l_lbound",
    mode = "numeric",
    na = TRUE
  )
  .CheckVal(
    x = l_ubound,
    arg = "l_ubound",
    mode = "numeric",
    na = TRUE
  )
  .CheckLabels(
    x = l_rows,
    arg = "l_rows"
  )
  .CheckLabels(
    x = l_cols,
    arg = "l_cols"
  )
  .MxHelperSigmaFromLDLMxMatrix(
    p = p,
    name = name,
    column_name = column_name,
    sdiag_name = sdiag_name,
    iden_name = iden_name,
    d_free = d_free,
    d_values = d_values,
    d_lbound = d_lbound,
    d_ubound = d_ubound,
    d_rows = d_rows,
    d_cols = d_cols,
    d_equal = d_equal,
    l_free = l_free,
    l_values = l_values,
    l_lbound = l_lbound,
    l_ubound = l_ubound,
    l_rows = l_rows,
    l_cols = l_cols
  )
}
# nolint end
