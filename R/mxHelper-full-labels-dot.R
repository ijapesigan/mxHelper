#' Labels of a Full Matrix (Internal)
#'
#' Builds the parameter labels of an `m` by `n` matrix
#' from the name of the matrix and the row and column indices.
#' No input checks: see [MxHelperFullLabels()].
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
#' .MxHelperFullLabels(
#'   m = 2,
#'   n = 2,
#'   name = "beta",
#'   sep = "underscore"
#' )
#'
#' @family Full Matrix Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperFullLabels <- function(m,
                                n,
                                name,
                                sep) {
  m_idx <- seq_len(length.out = m)
  n_idx <- seq_len(length.out = n)
  if (sep == "bracket") {
    out <- outer(
      X = m_idx,
      Y = n_idx,
      FUN = function(x, y) {
        paste0(
          name,
          "[",
          x,
          ",",
          y,
          "]"
        )
      }
    )
  }
  if (sep == "underscore") {
    out <- outer(
      X = m_idx,
      Y = n_idx,
      FUN = function(x, y) {
        paste0(
          name,
          "_",
          x,
          "_",
          y
        )
      }
    )
  }
  out
}
