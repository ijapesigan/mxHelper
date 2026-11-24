#' Relax the Actionable Bounds That Estimates Are at (Internal)
#'
#' Moves each finite bound that an estimate is at, when the hit
#' is actionable (`.MxHelperAtBounds()`), away from zero by `factor`:
#' a negative bound is multiplied by it, a positive one divided.
#' With `protect_lb_zero = TRUE`, a lower bound of zero is kept.
#' When the new bounds of a parameter cross, they are set around
#' their midpoint. Stops with an error unless `factor > 1`.
#' No input checks: see [MxHelperRelaxBoundsAtBounds()].
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
#' @param exclude Character vector or `NULL`.
#'   Labels of parameters whose bounds are never relaxed.
#' @param protect_lb_zero Logical.
#'   If `TRUE`, a lower bound of zero is never relaxed.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
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
#' fit <- .MxHelperRelaxBoundsAtBounds(
#'   x = fit
#' )
#'
#' @family Bounds Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperRelaxBoundsAtBounds <- function(x,
                                         factor = 10,
                                         abs_bnd_tol = 1e-6,
                                         rel_bnd_tol = 1e-4,
                                         exclude = NULL,
                                         protect_lb_zero = TRUE,
                                         allowed_bounds = NULL) {
  if (
    !is.numeric(x = factor) ||
      length(x = factor) != 1L ||
      !is.finite(x = factor) ||
      factor <= 1
  ) {
    stop(
      ".MxHelperRelaxBoundsAtBounds() requires factor > 1."
    )
  }

  pars <- OpenMx::omxGetParameters(model = x)

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

  nm <- intersect(
    x = intersect(
      x = names(x = lb),
      y = names(x = ub)
    ),
    y = names(x = pars)
  )

  bd <- .MxHelperAtBounds(
    x = x,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    allowed_bounds = allowed_bounds
  )

  # Only actionable bound hits are candidates for relaxation.
  hits <- (
    bd$actionable_lb[nm] |
      bd$actionable_ub[nm]
  )

  hits[is.na(x = hits)] <- FALSE

  targets <- nm[hits]

  # Existing exclusion mechanism remains unchanged.
  if (!is.null(x = exclude)) {
    targets <- setdiff(
      x = targets,
      y = exclude
    )
  }

  out <- x
  if (length(x = targets) > 0L) {
    new_lb <- lb
    new_ub <- ub

    for (k in targets) {
      if (
        isTRUE(
          x = bd$actionable_lb[k]
        ) &&
          is.finite(x = lb[k])
      ) {
        if (
          !(
            protect_lb_zero &&
              isTRUE(x = lb[k] == 0)
          )
        ) {
          new_lb[k] <- if (lb[k] < 0) {
            lb[k] * factor
          } else {
            lb[k] / factor
          }
        }
      }

      if (
        isTRUE(
          x = bd$actionable_ub[k]
        ) &&
          is.finite(x = ub[k])
      ) {
        new_ub[k] <- if (ub[k] > 0) {
          ub[k] * factor
        } else {
          ub[k] / factor
        }
      }

      if (
        is.finite(x = new_lb[k]) &&
          is.finite(x = new_ub[k]) &&
          new_lb[k] >= new_ub[k]
      ) {
        mid <- (
          new_lb[k] + new_ub[k]
        ) / 2

        span <- abs(x = mid) + 1

        new_lb[k] <- mid - span
        new_ub[k] <- mid + span
      }
    }

    out <- OpenMx::omxSetParameters(
      model = x,
      labels = targets,
      lbound = new_lb[targets],
      ubound = new_ub[targets]
    )
  }
  out
}
