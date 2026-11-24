#' Arguments of a Diag OpenMx Matrix (Internal)
#'
#' Builds the free elements, values, labels, and bounds of the diagonal of a
#' `p` by `p` matrix
#' for `OpenMx::mxMatrix()`.
#' Labels and bounds of fixed elements are set to `NA`.
#' No input checks: see [MxHelperDiagPrepMatrices()].
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
#' @param name Character string.
#'   Name of the matrix or algebra.
#'
#' @return Returns a list with the elements
#'   `free`, `values`, `labels`, `lbound`, `ubound`, and `vec`
#'   (the bracket labels of the free elements, or `FALSE`
#'   when `vec = FALSE`).
#'
#' @examples
#' .MxHelperDiagPrepMatrices(
#'   p = 2,
#'   free_val = NULL,
#'   values = NULL,
#'   lbound_val = NULL,
#'   ubound_val = NULL,
#'   vec = TRUE,
#'   name = "beta"
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperDiagPrepMatrices <- function(p,
                                      free_val,
                                      values,
                                      lbound_val,
                                      ubound_val,
                                      vec,
                                      name) {
  values <- .MxHelperDiagValues(
    p = p,
    val = values
  )
  free <- .MxHelperDiagFree(
    p = p,
    val = free_val
  )
  labels <- .MxHelperDiagLabels(
    p = p,
    name = name,
    sep = "underscore"
  )
  if (vec) {
    vec <- .MxHelperDiagLabels(
      p = p,
      name = name,
      sep = "bracket"
    )
    vec_run <- TRUE
  } else {
    vec_run <- FALSE
  }
  lbound <- .MxHelperDiagBound(
    p = p,
    val = lbound_val
  )
  ubound <- .MxHelperDiagBound(
    p = p,
    val = ubound_val
  )
  for (i in seq_len(length.out = p)) {
    if (!free[i]) {
      labels[i] <- NA
      lbound[i] <- NA
      ubound[i] <- NA
      if (vec_run) {
        vec[i] <- NA
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
