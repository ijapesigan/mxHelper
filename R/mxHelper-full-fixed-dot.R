#' A Fixed Full OpenMx Matrix (Internal)
#'
#' Builds an `m` by `n` OpenMx matrix of type `"Full"`
#' with no free elements.
#' No input checks: see [MxHelperFullFixed()].
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
#' .MxHelperFullFixed(
#'   m = 2,
#'   n = 2,
#'   values = diag(x = 2),
#'   row = NULL,
#'   col = NULL,
#'   name = "iden"
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperFullFixed <- function(m,
                               n,
                               values,
                               row,
                               col,
                               name) {
  if (is.null(x = values)) {
    values <- matrix(
      data = 0,
      nrow = m,
      ncol = n
    )
  }
  .MxHelperFullMxMatrix(
    m = m,
    n = n,
    free_val = FALSE,
    values = values,
    lbound_val = NA,
    ubound_val = NA,
    vec = FALSE,
    row = row,
    col = col,
    name = name
  )
}
