#' Arguments of a Full OpenMx Matrix
#'
#' Builds the free elements, values, labels, and bounds of an `m` by `n` matrix
#' for `OpenMx::mxMatrix()`.
#' Labels and bounds of fixed elements are set to `NA`.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param m Positive integer.
#'   Number of rows.
#' @param n Positive integer.
#'   Number of columns.
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
#' @param name Character string.
#'   Name of the matrix or algebra.
#'
#' @return Returns a list with the elements
#'   `free`, `values`, `labels`, `lbound`, `ubound`, and `vec`
#'   (the bracket labels of the free elements, or `FALSE`
#'   when `vec = FALSE`).
#'
#' @examples
#' MxHelperFullPrepMatrices(
#'   m = 2,
#'   n = 2,
#'   free_val = NULL,
#'   values = NULL,
#'   lbound_val = NULL,
#'   ubound_val = NULL,
#'   vec = TRUE,
#'   name = "beta"
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperFullPrepMatrices <- function(m,
                                     n,
                                     free_val,
                                     values,
                                     lbound_val,
                                     ubound_val,
                                     vec,
                                     name) {
  .CheckCount(
    x = m,
    arg = "m"
  )
  .CheckCount(
    x = n,
    arg = "n"
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
  .CheckString(
    x = name,
    arg = "name"
  )
  .MxHelperFullPrepMatrices(
    m = m,
    n = n,
    free_val = free_val,
    values = values,
    lbound_val = lbound_val,
    ubound_val = ubound_val,
    vec = vec,
    name = name
  )
}
