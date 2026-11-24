#' Relax the Bounds That Estimates Are at (Internal)
#'
#' Moves each finite bound that an estimate is at (`.MxHelperAtBounds()`)
#' away from zero by `factor`: a negative bound is multiplied by
#' it, a positive one divided. When the new bounds of a
#' parameter cross, they are set around their midpoint.
#' Unlike `.MxHelperRelaxBoundsAtBounds()`, it ignores `allowed_bounds`
#' and relaxes a lower bound of zero unchanged (zero stays
#' zero).
#' No input checks: see [MxHelperRelaxBounds()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
#' @param factor Number greater than 1.
#'   Factor by which a bound is moved away from zero.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param labels Character vector or `NULL`.
#'   Labels of the only parameters whose bounds may be relaxed.
#'   If `NULL`, all.
#' @param exclude Character vector or `NULL`.
#'   Labels of parameters whose bounds are never relaxed.
#'
#' @return Returns the model with the new bounds.
#'
#' @examples
#' set.seed(seed = 42)
#' x <- data.frame(
#'   y1 = rnorm(n = 50),
#'   y2 = rnorm(n = 50)
#' )
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' fit <- .MxHelperRelaxBounds(
#'   x = fit
#' )
#'
#' @family Bounds Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperRelaxBounds <- function(x,
                                 factor = 10,
                                 abs_bnd_tol = 1e-6,
                                 rel_bnd_tol = 1e-4,
                                 labels = NULL,
                                 exclude = NULL) {
  # bounds for FREE params (consistent with .MxHelperAtBounds)
  lb <- OpenMx::omxGetParameters(
    model = x,
    indep = FALSE,
    free = TRUE,
    fetch = "lbound"
  )
  ub <- OpenMx::omxGetParameters(
    model = x,
    indep = FALSE,
    free = TRUE,
    fetch = "ubound"
  )

  nm <- intersect(x = names(x = lb), y = names(x = ub))

  # --- only those at bounds ---
  bd <- .MxHelperAtBounds(
    x = x,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol
  )
  at <- union(
    x = names(x = bd$at_lb)[bd$at_lb],
    y = names(x = bd$at_ub)[bd$at_ub]
  )

  nm <- intersect(x = nm, y = at)

  # optional further restriction
  if (!is.null(x = labels)) {
    nm <- intersect(x = nm, y = labels)
  }
  if (!is.null(x = exclude)) {
    nm <- setdiff(x = nm, y = exclude)
  }

  out <- x
  if (length(x = nm) > 0L) {
    new_lb <- lb
    new_ub <- ub

    for (k in nm) {
      # relax ONLY the active side(s)
      if (isTRUE(x = bd$at_lb[k]) && is.finite(x = lb[k])) {
        # relax lower bound: push away from 0
        new_lb[k] <- if (lb[k] < 0) {
          lb[k] * factor
        } else {
          lb[k] / factor
        }
      }
      if (isTRUE(x = bd$at_ub[k]) && is.finite(x = ub[k])) {
        # relax upper bound: push away from 0
        new_ub[k] <- if (ub[k] > 0) {
          ub[k] * factor
        } else {
          ub[k] / factor
        }
      }

      # keep ordering sane if both finite
      if (
        is.finite(x = new_lb[k]) &&
          is.finite(x = new_ub[k]) &&
          new_lb[k] >= new_ub[k]
      ) {
        mid <- (new_lb[k] + new_ub[k]) / 2
        span <- abs(x = mid) + 1
        new_lb[k] <- mid - span
        new_ub[k] <- mid + span
      }
    }

    # set ONLY the touched labels (safer than blasting all)
    out <- OpenMx::omxSetParameters(
      model = x,
      labels = nm,
      lbound = new_lb[nm],
      ubound = new_ub[nm]
    )
  }
  out
}
