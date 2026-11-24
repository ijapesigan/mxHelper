#' A Sym OpenMx Matrix (Internal)
#'
#' Builds a `p` by `p` symmetric matrix as an OpenMx matrix of type
#' `"Symm"`.
#' With `vec = TRUE`, it also builds a column vector
#' (`<name>_vec`) of the free elements, labelled with
#' their bracket labels, so that they can be extracted
#' as a vector.
#' No input checks: see [MxHelperSymMxMatrix()].
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
#' .MxHelperSymMxMatrix(
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
#' @keywords mxHelper internal
#' @noRd
.MxHelperSymMxMatrix <- function(p,
                                 free_val,
                                 values,
                                 lbound_val,
                                 ubound_val,
                                 vec,
                                 row,
                                 col,
                                 name) {
  matrices <- .MxHelperSymPrepMatrices(
    p = p,
    free_val = free_val,
    values = values,
    lbound_val = lbound_val,
    ubound_val = ubound_val,
    vec = vec,
    name = name
  )
  if (is.null(x = row)) {
    row <- paste0(
      "i_",
      seq_len(length.out = p)
    )
  }
  if (is.null(x = col)) {
    col <- paste0(
      "j_",
      seq_len(length.out = p)
    )
  }
  out <- list()
  mat <- OpenMx::mxMatrix(
    type = "Symm",
    nrow = p,
    ncol = p,
    free = matrices$free,
    values = matrices$values,
    labels = matrices$labels,
    lbound = matrices$lbound,
    ubound = matrices$ubound,
    byrow = FALSE,
    dimnames = list(
      row,
      col
    ),
    name = name
  )
  out <- c(
    out,
    stats::setNames(
      object = list(mat),
      nm = name
    )
  )
  if (is.matrix(x = matrices$vec)) {
    vec <- unique(
      x = c(
        stats::na.omit(
          object = c(
            matrices$vec
          )
        )
      )
    )
    p <- length(x = vec)
    if (p > 0) {
      vec_free <- OpenMx::mxMatrix(
        type = "Full",
        nrow = p,
        ncol = 1,
        labels = vec,
        dimnames = list(
          vec,
          paste0(
            name,
            "_vec"
          )
        ),
        name = paste0(
          name,
          "_vec"
        )
      )
      out <- c(
        out,
        stats::setNames(
          object = list(vec_free),
          nm = paste0(
            name,
            "_vec"
          )
        )
      )
    }
  }
  out
}
