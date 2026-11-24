#' Labels of a Sym Matrix (Internal)
#'
#' Builds the parameter labels of a `p` by `p` symmetric matrix
#' from the name of the matrix and the row and column indices.
#' The lower triangle is copied to the upper triangle.
#' No input checks: see [MxHelperSymLabels()].
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
#' .MxHelperSymLabels(
#'   p = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Symmetric Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSymLabels <- function(p,
                               name,
                               sep) {
  out <- .MxHelperFullLabels(
    m = p,
    n = p,
    name = name,
    sep = sep
  )
  out[upper.tri(x = out)] <- t(x = out)[upper.tri(x = out)]
  out
}
