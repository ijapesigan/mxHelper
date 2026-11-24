#' Move Estimates off Their Bounds (Internal)
#'
#' Moves each estimate at an actionable bound (`.MxHelperAtBounds()`)
#' inward by `mult` times the bound tolerance, without crossing
#' the opposite bound. Other estimates are unchanged.
#' No input checks: see [MxHelperNudgeOffBounds()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param mult Positive number.
#'   Multiple of the bound tolerance by which an estimate
#'   is moved inward.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns the model with the new values.
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
#' fit <- .MxHelperNudgeOffBounds(
#'   x = fit
#' )
#'
#' @family Bounds Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperNudgeOffBounds <- function(x,
                                    abs_bnd_tol = 1e-6,
                                    rel_bnd_tol = 1e-4,
                                    mult = 10,
                                    allowed_bounds = NULL) {
  pars <- OpenMx::omxGetParameters(model = x)
  nm <- names(x = pars)

  lb <- OpenMx::omxGetParameters(
    model = x,
    indep = FALSE,
    free = TRUE,
    fetch = "lbound"
  )[nm]

  ub <- OpenMx::omxGetParameters(
    model = x,
    indep = FALSE,
    free = TRUE,
    fetch = "ubound"
  )[nm]

  bd <- .MxHelperAtBounds(
    x = x,
    abs_bnd_tol = abs_bnd_tol,
    rel_bnd_tol = rel_bnd_tol,
    allowed_bounds = allowed_bounds
  )

  # Scale used for step sizes.
  # Replace non-finite scale with 1.
  sc_lb <- pmax(
    abs(x = pars),
    abs(x = lb),
    1
  )
  sc_lb[!is.finite(x = sc_lb)] <- 1

  sc_ub <- pmax(
    abs(x = pars),
    abs(x = ub),
    1
  )
  sc_ub[!is.finite(x = sc_ub)] <- 1

  # Step size that clears the tolerance band used by
  # .MxHelperAtBounds().
  step_lb <- mult * (
    abs_bnd_tol + rel_bnd_tol * sc_lb
  )

  step_ub <- mult * (
    abs_bnd_tol + rel_bnd_tol * sc_ub
  )

  # Inner clamp amount.
  inner_tol <- function(val,
                        bnd) {
    sc <- pmax(
      abs(x = val),
      abs(x = bnd),
      1
    )

    sc[!is.finite(x = sc)] <- 1

    abs_bnd_tol + rel_bnd_tol * sc
  }

  # Nudge inward only from ACTIONABLE lower bounds.
  if (
    any(
      bd$actionable_lb,
      na.rm = TRUE
    )
  ) {
    idx <- which(
      x = bd$actionable_lb
    )

    pars[idx] <- pars[idx] + step_lb[idx]

    finite_ub <- is.finite(
      x = ub[idx]
    )

    if (any(finite_ub)) {
      iu <- idx[finite_ub]

      pars[iu] <- pmin(
        pars[iu],
        ub[iu] - inner_tol(
          pars[iu],
          ub[iu]
        )
      )
    }
  }

  # Nudge inward only from ACTIONABLE upper bounds.
  if (
    any(
      bd$actionable_ub,
      na.rm = TRUE
    )
  ) {
    idx <- which(
      x = bd$actionable_ub
    )

    pars[idx] <- pars[idx] - step_ub[idx]

    finite_lb <- is.finite(
      x = lb[idx]
    )

    if (any(finite_lb)) {
      il <- idx[finite_lb]

      pars[il] <- pmax(
        pars[il],
        lb[il] + inner_tol(
          pars[il],
          lb[il]
        )
      )
    }
  }

  OpenMx::omxSetParameters(
    model = x,
    labels = nm,
    values = pars
  )
}
