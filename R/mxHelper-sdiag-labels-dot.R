#' Labels of a Sdiag Matrix (Internal)
#'
#' Builds the parameter labels of a `p` by `p` strictly lower triangular matrix
#' from the name of the matrix and the row and column indices.
#' The diagonal and the upper triangle have no labels.
#' No input checks: see [MxHelperSdiagLabels()].
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
#' .MxHelperSdiagLabels(
#'   p = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Strictly Lower Triangular Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperSdiagLabels <- function(p,
                                 name,
                                 sep) {
  out <- .MxHelperFullLabels(
    m = p,
    n = p,
    name = name,
    sep = sep
  )
  out[
    upper.tri(
      x = out,
      diag = TRUE
    )
  ] <- NA
  out
}
