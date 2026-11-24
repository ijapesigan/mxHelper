# nolint start: object_name_linter, object_length_linter.
#' OpenMx Matrices of a Diagonal Covariance Matrix (Internal)
#'
#' Builds a diagonal covariance matrix whose diagonal is the
#' softplus of an unconstrained column vector: the column vector
#' (`column_name`), the algebra (`name`), its half-vectorization
#' (`<name>_vech`), and a column vector of the free elements
#' (`<name>_vec`).
#' With `d_equal = TRUE`, the free diagonal elements are equal.
#' No input checks: see [MxHelperSigmaDiagFromLDLMxMatrix()].
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
#' .MxHelperSigmaDiagFromLDLMxMatrix(
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
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaDiagFromLDLMxMatrix <- function(p,
                                              name,
                                              column_name,
                                              d_free,
                                              d_values,
                                              d_lbound,
                                              d_ubound,
                                              d_rows,
                                              d_cols,
                                              d_equal) {
  if (is.null(x = d_values)) {
    d_values <- rep(
      x = log(x = expm1(x = 1)),
      times = p
    )
  } else {
    if (is.matrix(x = d_values)) {
      if (all(dim(x = d_values) == c(p, p))) {
        d_values <- diag(x = d_values)
      }
      if (all(dim(x = d_values) == c(p, 1))) {
        d_values <- c(d_values)
      }
    }
    stopifnot(
      is.vector(x = d_values),
      length(x = d_values) == p
    )
  }
  out <- list()
  column <- .MxHelperFullMxMatrix(
    m = p,
    n = 1,
    free_val = d_free,
    values = d_values,
    lbound_val = d_lbound,
    ubound_val = d_ubound,
    vec = TRUE,
    row = d_rows,
    col = d_cols,
    name = column_name
  )
  if (isTRUE(x = d_equal)) {
    mat <- column[[1]]
    eq_label <- paste0(
      column_name,
      "_eq"
    )
    fr <- matrix(
      data = mat@free,
      nrow = p,
      ncol = 1
    )
    lab <- matrix(
      data = mat@labels,
      nrow = p,
      ncol = 1
    )
    val <- matrix(
      data = mat@values,
      nrow = p,
      ncol = 1
    )
    lab[fr] <- eq_label
    v0 <- if (length(x = d_values) > 0) {
      d_values[1]
    } else {
      log(x = expm1(x = 1))
    }
    val[fr] <- v0
    if (!is.null(x = mat@lbound)) {
      lb <- matrix(
        data = mat@lbound,
        nrow = p,
        ncol = 1
      )
      lb[fr] <- if (length(x = d_lbound)) {
        d_lbound[1]
      } else {
        lb[fr]
      }
      mat@lbound <- lb
    }
    if (!is.null(x = mat@ubound)) {
      ub <- matrix(
        data = mat@ubound,
        nrow = p,
        ncol = 1
      )
      ub[fr] <- if (length(x = d_ubound)) {
        d_ubound[1]
      } else {
        ub[fr]
      }
      mat@ubound <- ub
    }
    mat@labels <- lab
    mat@values <- val
    column[[1]] <- mat
  }
  if (length(x = column) == 1) {
    names(x = column) <- column_name
  } else {
    names(x = column) <- c(
      column_name,
      paste0(
        column_name,
        "_",
        "vec"
      )
    )
  }
  out <- c(
    out,
    column
  )
  sigma <- .MxHelperSigmaDiagFromLDLSoftplusAlgebra(
    column = column_name,
    name = name
  )
  out <- c(
    out,
    stats::setNames(
      object = list(sigma),
      nm = name
    )
  )
  sigma_vech <- OpenMx::mxAlgebraFromString(
    algString = paste0(
      "vech(",
      name,
      ")"
    ),
    name = paste0(
      name,
      "_",
      "vech"
    )
  )
  out <- c(
    out,
    stats::setNames(
      object = list(sigma_vech),
      nm = paste0(
        name,
        "_",
        "vech"
      )
    )
  )
  free <- matrix(
    data = FALSE,
    nrow = p,
    ncol = p
  )
  diag(x = free) <- c(
    column[[1]]@free
  )
  vec <- matrix(
    data = NA_character_,
    nrow = p,
    ncol = p
  )
  for (j in seq_len(length.out = p)) {
    for (i in seq_len(length.out = p)) {
      if (free[i, j]) {
        vec[i, j] <- paste0(
          name,
          "[",
          i,
          ",",
          j,
          "]"
        )
      }
    }
  }
  vec <- unique(
    x = c(
      stats::na.omit(
        object = c(
          vec
        )
      )
    )
  )
  q <- length(x = vec)
  if (q > 0) {
    vec_free <- OpenMx::mxMatrix(
      type = "Full",
      nrow = q,
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
  out
}
# nolint end
