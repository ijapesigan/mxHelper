# nolint start: object_name_linter, object_length_linter.
#' OpenMx Matrices of a Diagonal Covariance Matrix
#'
#' Builds a diagonal covariance matrix whose diagonal is the
#' softplus of an unconstrained column vector: the column vector
#' (`column_name`), the algebra (`name`), its half-vectorization
#' (`<name>_vech`), and a column vector of the free elements
#' (`<name>_vec`).
#' With `d_equal = TRUE`, the free diagonal elements are equal.
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
#'
#' @return Returns a named list of OpenMx matrices and algebras.
#'
#' @examples
#' MxHelperSigmaDiagFromLDLMxMatrix(
#'   p = 2,
#'   name = "sigma",
#'   column_name = "sigma_d",
#'   d_free = TRUE,
#'   d_values = NULL,
#'   d_lbound = NA,
#'   d_ubound = NA,
#'   d_rows = NULL,
#'   d_cols = NULL,
#'   d_equal = FALSE
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSigmaDiagFromLDLMxMatrix <- function(p,
                                             name,
                                             column_name,
                                             d_free,
                                             d_values,
                                             d_lbound,
                                             d_ubound,
                                             d_rows,
                                             d_cols,
                                             d_equal) {
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
  .MxHelperSigmaDiagFromLDLMxMatrix(
    p = p,
    name = name,
    column_name = column_name,
    d_free = d_free,
    d_values = d_values,
    d_lbound = d_lbound,
    d_ubound = d_ubound,
    d_rows = d_rows,
    d_cols = d_cols,
    d_equal = d_equal
  )
}
# nolint end
