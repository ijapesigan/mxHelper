#' Labels of a Sdiag Matrix
#'
#' Builds the parameter labels of a `p` by `p` strictly lower triangular matrix
#' from the name of the matrix and the row and column indices.
#' The diagonal and the upper triangle have no labels.
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
#' @return Returns a character matrix.
#'
#' @examples
#' MxHelperSdiagLabels(
#'   p = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSdiagLabels <- function(p,
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
  .MxHelperSdiagLabels(
    p = p,
    name = name,
    sep = sep
  )
}
