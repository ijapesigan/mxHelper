# nolint start: object_name_linter, object_length_linter.
#' OpenMx Matrices of a Covariance Matrix from LDL Parts (Internal)
#'
#' The covariance matrix is
#' \eqn{\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
#' \boldsymbol{L}^{\prime}},
#' with \eqn{\boldsymbol{L}} unit lower triangular and \eqn{\boldsymbol{D}}
#' diagonal; the diagonal of \eqn{\boldsymbol{D}} is the softplus
#' of an unconstrained vector, so \eqn{\boldsymbol{\Sigma}} stays
#' positive definite.
#' This function builds the OpenMx matrices and algebras:
#' \eqn{\boldsymbol{L}} below the diagonal (`sdiag_name`),
#' the unconstrained diagonal of \eqn{\boldsymbol{D}} (`column_name`),
#' the identity (when `iden_name = NULL`),
#' \eqn{\boldsymbol{\Sigma}} (`name`), its half-vectorization
#' (`<name>_vech`), and a column vector of the free elements
#' (`<name>_vec`).
#' No input checks: see [MxHelperSigmaFromLDLMxMatrix()].
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
#' @param sdiag_name Character string.
#'   Name of the strictly lower triangular matrix of
#'   \eqn{\boldsymbol{L}}.
#' @param iden_name Character string or `NULL`.
#'   Name of the identity matrix.
#'   If `NULL`, the function adds one named `<name>_iden`;
#'   otherwise the model must hold it.
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
#' @param l_free Logical vector or matrix, or `NULL`.
#'   Which elements of \eqn{\boldsymbol{L}} below the diagonal are
#'   free. `NULL` means all.
#' @param l_values Numeric vector or matrix, or `NULL`.
#'   Starting values of \eqn{\boldsymbol{L}} below the diagonal.
#'   `NULL` means zeros.
#' @param l_lbound Numeric vector or matrix, or `NULL`.
#'   Lower bounds of \eqn{\boldsymbol{L}} below the diagonal.
#' @param l_ubound Numeric vector or matrix, or `NULL`.
#'   Upper bounds of \eqn{\boldsymbol{L}} below the diagonal.
#' @param l_rows Character vector or `NULL`.
#'   Row names of \eqn{\boldsymbol{L}}.
#' @param l_cols Character vector or `NULL`.
#'   Column names of \eqn{\boldsymbol{L}}.
#'
#' @return Returns a named list of OpenMx matrices and algebras.
#'
#' @examples
#' ldl <- .MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#' .MxHelperSigmaFromLDLMxMatrix(
#'   p = 2,
#'   name = "sigma",
#'   column_name = "sigma_d",
#'   sdiag_name = "sigma_l",
#'   iden_name = NULL,
#'   d_free = TRUE,
#'   d_values = ldl$uc_d,
#'   d_lbound = NA,
#'   d_ubound = NA,
#'   d_rows = NULL,
#'   d_cols = NULL,
#'   d_equal = FALSE,
#'   l_free = TRUE,
#'   l_values = ldl$s_l,
#'   l_lbound = NA,
#'   l_ubound = NA,
#'   l_rows = NULL,
#'   l_cols = NULL
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaFromLDLMxMatrix <- function(p,
                                          name,
                                          column_name,
                                          sdiag_name,
                                          iden_name,
                                          d_free,
                                          d_values,
                                          d_lbound,
                                          d_ubound,
                                          d_rows,
                                          d_cols,
                                          d_equal,
                                          l_free,
                                          l_values,
                                          l_lbound,
                                          l_ubound,
                                          l_rows,
                                          l_cols) {
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
  sdiag <- .MxHelperSdiagMxMatrix(
    p = p,
    free_val = l_free,
    values = l_values,
    lbound_val = l_lbound,
    ubound_val = l_ubound,
    vec = TRUE,
    row = l_rows,
    col = l_cols,
    name = sdiag_name
  )
  if (length(x = sdiag) == 1) {
    names(x = sdiag) <- sdiag_name
  } else {
    names(x = sdiag) <- c(
      sdiag_name,
      paste0(
        sdiag_name,
        "_",
        "vec"
      )
    )
  }
  out <- c(
    out,
    sdiag
  )
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
  if (d_equal) {
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
  if (is.null(x = iden_name)) {
    iden_name <- paste0(
      name,
      "_iden"
    )
    iden <- OpenMx::mxMatrix(
      type = "Iden",
      nrow = p,
      ncol = p,
      name = iden_name
    )
    out <- c(
      out,
      stats::setNames(
        object = list(iden),
        nm = iden_name
      )
    )
  }
  sigma <- .MxHelperSigmaFromLDLSoftplusAlgebra(
    sdiag = sdiag_name,
    column = column_name,
    iden = iden_name,
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
  free <- sdiag[[1]]@free
  diag(x = free) <- c(column[[1]]@free)
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
  out
}
# nolint end
