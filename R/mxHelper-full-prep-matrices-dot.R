#' Arguments of a Full OpenMx Matrix (Internal)
#'
#' Builds the free elements, values, labels, and bounds of an `m` by `n` matrix
#' for `OpenMx::mxMatrix()`.
#' Labels and bounds of fixed elements are set to `NA`.
#' No input checks: see [MxHelperFullPrepMatrices()].
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
#' .MxHelperFullPrepMatrices(
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
#' @keywords mxHelper internal
#' @noRd
.MxHelperFullPrepMatrices <- function(m,
                                      n,
                                      free_val,
                                      values,
                                      lbound_val,
                                      ubound_val,
                                      vec,
                                      name) {
  values <- .MxHelperFullValues(
    m = m,
    n = n,
    val = values
  )
  free <- .MxHelperFullFree(
    m = m,
    n = n,
    val = free_val
  )
  labels <- .MxHelperFullLabels(
    m = m,
    n = n,
    name = name,
    sep = "underscore"
  )
  if (vec) {
    vec <- .MxHelperFullLabels(
      m = m,
      n = n,
      name = name,
      sep = "bracket"
    )
    vec_run <- TRUE
  } else {
    vec_run <- FALSE
  }
  lbound <- .MxHelperFullBound(
    m = m,
    n = n,
    val = lbound_val
  )
  ubound <- .MxHelperFullBound(
    m = m,
    n = n,
    val = ubound_val
  )
  for (j in seq_len(length.out = n)) {
    for (i in seq_len(length.out = m)) {
      if (!free[i, j]) {
        labels[i, j] <- NA
        lbound[i, j] <- NA
        ubound[i, j] <- NA
        if (vec_run) {
          vec[i, j] <- NA
        }
      }
    }
  }
  list(
    free = free,
    values = values,
    labels = labels,
    lbound = lbound,
    ubound = ubound,
    vec = vec
  )
}
