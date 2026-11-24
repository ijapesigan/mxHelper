#' Labels of a Diag Matrix
#'
#' Builds the parameter labels of the diagonal of a `p` by `p` matrix
#' from the name of the matrix and the row and column indices.
#' Only the diagonal is kept.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param p Positive integer.
#'   Number of rows and columns of the square matrix.
#' @param name Character string.
#'   Name of the matrix or algebra.
#' @param sep Character string.
#'   Separator of the row and column indices in the labels:
#'   `"underscore"` (`name_i_j`) or `"bracket"` (`name[i,j]`).
#'
#' @return Returns a character vector of length `p`.
#'
#' @examples
#' MxHelperDiagLabels(
#'   p = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Diagonal Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperDiagLabels <- function(p,
                               name,
                               sep) {
  .CheckCount(
    x = p,
    arg = "p"
  )
  .CheckString(
    x = name,
    arg = "name"
  )
  .CheckSep(
    x = sep
  )
  .MxHelperDiagLabels(
    p = p,
    name = name,
    sep = sep
  )
}
