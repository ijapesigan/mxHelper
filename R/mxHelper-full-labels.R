#' Labels of a Full Matrix
#'
#' Builds the parameter labels of an `m` by `n` matrix
#' from the name of the matrix and the row and column indices.
#' The arguments are checked first; the internal version,
#' without checks, is the one other projects copy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param m Positive integer.
#'   Number of rows.
#' @param n Positive integer.
#'   Number of columns.
#' @param name Character string.
#'   Name of the matrix or algebra.
#' @param sep Character string.
#'   Separator of the row and column indices in the labels:
#'   `"underscore"` (`name_i_j`) or `"bracket"` (`name[i,j]`).
#'
#' @return Returns a character matrix.
#'
#' @examples
#' MxHelperFullLabels(
#'   m = 2,
#'   n = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper
#' @export
MxHelperFullLabels <- function(m,
                               n,
                               name,
                               sep) {
  .CheckCount(
    x = m,
    arg = "m"
  )
  .CheckCount(
    x = n,
    arg = "n"
  )
  .CheckString(
    x = name,
    arg = "name"
  )
  .CheckSep(
    x = sep
  )
  .MxHelperFullLabels(
    m = m,
    n = n,
    name = name,
    sep = sep
  )
}
