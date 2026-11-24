#' Labels of a Sym Matrix
#'
#' Builds the parameter labels of a `p` by `p` symmetric matrix
#' from the name of the matrix and the row and column indices.
#' The lower triangle is copied to the upper triangle.
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
#' MxHelperSymLabels(
#'   p = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperSymLabels <- function(p,
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
  .MxHelperSymLabels(
    p = p,
    name = name,
    sep = sep
  )
}
