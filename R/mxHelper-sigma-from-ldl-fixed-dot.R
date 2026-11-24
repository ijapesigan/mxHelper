#' Fixed Covariance Matrix from LDL Parts (Internal)
#'
#' Builds a covariance matrix with no free elements from the
#' strictly lower triangular part of \eqn{\boldsymbol{L}} and the
#' unconstrained diagonal of \eqn{\boldsymbol{D}},
#' as `.MxHelperSigmaFromLDLMxMatrix()` does.
#' The matrices are named `<name>_l` and `<name>_d`;
#' the model must hold the identity matrix `iden_name`.
#' No input checks: see [MxHelperSigmaFromLDLFixed()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param d_values Numeric vector.
#'   Unconstrained diagonal of \eqn{\boldsymbol{D}}
#'   (the element `uc_d` of `LDL`).
#' @param l_values Numeric matrix.
#'   Strictly lower triangular part of \eqn{\boldsymbol{L}}
#'   (the element `s_l` of `LDL`).
#' @param row Character vector or `NULL`.
#'   Names of the variables (rows and columns).
#' @param name Character string.
#'   Name of the matrix or algebra.
#' @param iden_name Character string or `NULL`.
#'   Name of the identity matrix, which the model must hold.
#'   If `NULL`, `<name>_iden`.
#'
#' @return Returns a named list of OpenMx matrices and algebras.
#'
#' @examples
#' ldl <- .MxHelperLDL(
#'   x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
#' )
#' .MxHelperSigmaFromLDLFixed(
#'   p = 2,
#'   d_values = ldl$uc_d,
#'   l_values = ldl$s_l,
#'   row = c("y1", "y2"),
#'   name = "sigma",
#'   iden_name = NULL
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaFromLDLFixed <- function(p,
                                       d_values,
                                       l_values,
                                       row,
                                       name,
                                       iden_name) {
  if (is.null(x = d_values) || is.null(x = l_values)) {
    stop(
      paste(
        "\nColumn and off-diagonal values",
        "for the LDL decompositon required.\n"
      )
    )
  }
  column_name <- paste0(name, "_", "d")
  sdiag_name <- paste0(name, "_", "l")
  if (is.null(x = iden_name)) {
    iden_name <- paste0(name, "_", "iden")
  }
  .MxHelperSigmaFromLDLMxMatrix(
    p = p,
    name = name,
    column_name = column_name,
    sdiag_name = sdiag_name,
    iden_name = iden_name,
    d_free = FALSE,
    d_values = d_values,
    d_lbound = NA,
    d_ubound = NA,
    d_rows = row,
    d_cols = column_name,
    d_equal = FALSE,
    l_free = FALSE,
    l_values = l_values,
    l_lbound = NA,
    l_ubound = NA,
    l_rows = row,
    l_cols = row
  )
}
