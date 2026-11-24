#' Fixed Covariance Matrix (Internal)
#'
#' Builds a covariance matrix with no free elements, from `values`
#' or, when `values = NULL`, from `type`,
#' as `.MxHelperSigmaFromLDLMxMatrix()` does.
#' The model must hold the identity matrix `iden_name`.
#' No input checks: see [MxHelperSigmaFixed()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param values Numeric matrix or `NULL`.
#'   Covariance matrix. If `NULL`, set by `type`.
#' @param row Character vector or `NULL`.
#'   Names of the variables (rows and columns).
#' @param name Character string.
#'   Name of the matrix or algebra.
#' @param iden_name Character string or `NULL`.
#'   Name of the identity matrix, which the model must hold.
#'   If `NULL`, `<name>_iden`.
#' @param type Character string or `NULL`.
#'   Covariance when `values = NULL`: `"zero"` (1e-10 times
#'   the identity), `"identity"`, or `"diffused"` (1e10 times
#'   the identity).
#'   The algebra adds 1e-8 to each element of the diagonal of
#'   the LDL decomposition, so `"zero"` evaluates to
#'   (1e-10 + 1e-8) times the identity.
#'
#' @return Returns a named list of OpenMx matrices and algebras.
#'
#' @examples
#' .MxHelperSigmaFixed(
#'   p = 2,
#'   values = NULL,
#'   row = c("y1", "y2"),
#'   name = "sigma",
#'   iden_name = NULL,
#'   type = "identity"
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSigmaFixed <- function(p,
                                values,
                                row,
                                name,
                                iden_name = NULL,
                                type) {
  if (is.null(x = values)) {
    if (is.null(x = type)) {
      stop("Argument `type` not provided.")
    }
    scalar <- switch(
      EXPR = type,
      zero = 1e-10,
      identity = 1,
      diffused = 1e10,
      stop("Unknown type: ", type)
    )
    values <- scalar * diag(x = p)
  }
  ldl <- .MxHelperLDL(x = values)
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
    d_values = ldl$uc_d,
    d_lbound = NA,
    d_ubound = NA,
    d_rows = row,
    d_cols = column_name,
    d_equal = FALSE,
    l_free = FALSE,
    l_values = ldl$s_l,
    l_lbound = NA,
    l_ubound = NA,
    l_rows = row,
    l_cols = row
  )
}
