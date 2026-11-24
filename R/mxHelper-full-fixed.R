#' A Fixed Full OpenMx Matrix
#'
#' Builds an `m` by `n` OpenMx matrix of type `"Full"`
#' with no free elements.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param m Positive integer.
#'   Number of rows.
#' @param n Positive integer.
#'   Number of columns.
#' @param values Numeric matrix or `NULL`.
#'   Fixed values of the matrix.
#'   If `NULL`, zeros.
#' @param row Character vector or `NULL`.
#'   Row names of the matrix.
#'   If `NULL`, `i_1`, ..., `i_m`.
#' @param col Character vector or `NULL`.
#'   Column names of the matrix.
#'   If `NULL`, `j_1`, ..., `j_n`.
#' @param name Character string.
#'   Name of the matrix or algebra.
#'
#' @return Returns a named list with one OpenMx matrix, `name`.
#'
#' @examples
#' MxHelperFullFixed(
#'   m = 2,
#'   n = 2,
#'   values = diag(x = 2),
#'   row = NULL,
#'   col = NULL,
#'   name = "iden"
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperFullFixed <- function(m,
                              n,
                              values,
                              row,
                              col,
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
    x = values,
    arg = "values",
    mode = "numeric",
    na = FALSE
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
  .MxHelperFullFixed(
    m = m,
    n = n,
    values = values,
    row = row,
    col = col,
    name = name
  )
}
