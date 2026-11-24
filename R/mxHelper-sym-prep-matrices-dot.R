#' Arguments of a Sym OpenMx Matrix (Internal)
#'
#' Builds the free elements, values, labels, and bounds of a `p` by `p`
#' symmetric matrix
#' for `OpenMx::mxMatrix()`.
#' Labels and bounds of fixed elements are set to `NA`.
#' No input checks: see [MxHelperSymPrepMatrices()].
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
#' .MxHelperSymPrepMatrices(
#'   p = 2,
#'   free_val = NULL,
#'   values = NULL,
#'   lbound_val = NULL,
#'   ubound_val = NULL,
#'   vec = TRUE,
#'   name = "beta"
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSymPrepMatrices <- function(p,
                                     free_val,
                                     values,
                                     lbound_val,
                                     ubound_val,
                                     vec,
                                     name) {
  values <- .MxHelperSymValues(
    p = p,
    val = values
  )
  free <- .MxHelperSymFree(
    p = p,
    val = free_val
  )
  labels <- .MxHelperSymLabels(
    p = p,
    name = name,
    sep = "underscore"
  )
  if (vec) {
    vec <- .MxHelperSymLabels(
      p = p,
      name = name,
      sep = "bracket"
    )
    vec_run <- TRUE
  } else {
    vec_run <- FALSE
  }
  lbound <- .MxHelperSymBound(
    p = p,
    val = lbound_val
  )
  ubound <- .MxHelperSymBound(
    p = p,
    val = ubound_val
  )
  for (j in seq_len(length.out = p)) {
    for (i in seq_len(length.out = p)) {
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
