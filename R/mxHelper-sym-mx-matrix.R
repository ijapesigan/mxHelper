#' A Sym OpenMx Matrix
#'
#' Builds a `p` by `p` symmetric matrix as an OpenMx matrix of type
#' `"Symm"`.
#' With `vec = TRUE`, it also builds a column vector
#' (`<name>_vec`) of the free elements, labelled with
#' their bracket labels, so that they can be extracted
#' as a vector.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param free_val Logical vector or matrix, or `NULL`.
#'   Which elements are free parameters.
#'   A single value is recycled; `NULL` means all free.
#' @param values Numeric vector or matrix, or `NULL`.
#'   Starting values.
#'   A single value is recycled; `NULL` means zeros.
#' @param lbound_val Numeric vector or matrix, or `NULL`.
#'   Lower bounds of the free elements.
#'   A single value is recycled; `NULL` or `NA` means none.
#' @param ubound_val Numeric vector or matrix, or `NULL`.
#'   Upper bounds of the free elements.
#'   A single value is recycled; `NULL` or `NA` means none.
#' @param vec Logical.
#'   If `TRUE`, also return the bracket labels of the free elements,
#'   for a column vector of free parameters.
#' @param row Character vector or `NULL`.
#'   Row names of the matrix.
#'   If `NULL`, `i_1`, ..., `i_m`.
#' @param col Character vector or `NULL`.
#'   Column names of the matrix.
#'   If `NULL`, `j_1`, ..., `j_n`.
#' @param name Character string.
#'   Name of the matrix or algebra.
#'
#' @return Returns a named list of OpenMx matrices:
#'   the matrix `name`, and with `vec = TRUE` and at least one
#'   free element, the column vector `<name>_vec`.
#'
#' @examples
#' MxHelperSymMxMatrix(
#'   p = 2,
#'   free_val = NULL,
#'   values = NULL,
#'   lbound_val = NULL,
#'   ubound_val = NULL,
#'   vec = TRUE,
#'   row = NULL,
#'   col = NULL,
#'   name = "beta"
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSymMxMatrix <- function(p,
                                free_val,
                                values,
                                lbound_val,
                                ubound_val,
                                vec,
                                row,
                                col,
                                name) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckVal(
    x = free_val,
    arg = "free_val",
    mode = "logical",
    na = FALSE
  )
  .CheckVal(
    x = values,
    arg = "values",
    mode = "numeric",
    na = FALSE
  )
  .CheckVal(
    x = lbound_val,
    arg = "lbound_val",
    mode = "numeric",
    na = TRUE
  )
  .CheckVal(
    x = ubound_val,
    arg = "ubound_val",
    mode = "numeric",
    na = TRUE
  )
  .CheckFlag(
    x = vec,
    arg = "vec"
  )
  .CheckLabels(
    x = row,
    arg = "row"
  )
  .CheckLabels(
    x = col,
    arg = "col"
  )
  .CheckString(
    x = name,
    arg = "name"
  )
  .MxHelperSymMxMatrix(
    p = p,
    free_val = free_val,
    values = values,
    lbound_val = lbound_val,
    ubound_val = ubound_val,
    vec = vec,
    row = row,
    col = col,
    name = name
  )
}
