#' Fixed Covariance Matrix
#'
#' Builds a covariance matrix with no free elements, from `values`
#' or, when `values = NULL`, from `type`,
#' as [MxHelperSigmaFromLDLMxMatrix()] does.
#' The model must hold the identity matrix `iden_name`.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
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
#' MxHelperSigmaFixed(
#'   p = 2,
#'   values = NULL,
#'   row = c("y1", "y2"),
#'   name = "sigma",
#'   iden_name = NULL,
#'   type = "identity"
#' )
#'
#' @family Covariance Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSigmaFixed <- function(p,
                               values,
                               row,
                               name,
                               iden_name = NULL,
                               type) {
  .CheckCount(
    x = p,
    arg = "p"
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
  .CheckString(
    x = name,
    arg = "name"
  )
  if (!is.null(x = iden_name)) {
    .CheckString(
      x = iden_name,
      arg = "iden_name"
    )
  }
  .CheckType(
    x = type
  )
  .MxHelperSigmaFixed(
    p = p,
    values = values,
    row = row,
    name = name,
    iden_name = iden_name,
    type = type
  )
}
