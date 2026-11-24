#' Which Estimates Are at a Bound? (Internal)
#'
#' Finds the free parameters whose estimates are at their lower
#' or upper bound, within
#' \eqn{\tau_{\mathrm{abs}} + \tau_{\mathrm{rel}}
#' \max \left( \left| \hat{\theta} \right|, \left| b \right|,
#' 1 \right)}.
#' A hit is actionable unless the parameter is listed in
#' `allowed_bounds` for that side.
#' No input checks: see [MxHelperAtBounds()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x An OpenMx model (`MxModel`), usually fitted.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns a list with the elements
#'   \describe{
#'     \item{any}{`TRUE` if any estimate is at a bound.}
#'     \item{actionable}{`TRUE` if any hit is actionable.}
#'     \item{at_lb, at_ub}{Named logical vectors: at the lower,
#'       at the upper bound.}
#'     \item{actionable_lb, actionable_ub}{The same, actionable hits
#'       only.}
#'   }
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
#' .MxHelperAtBounds(
#'   x = fit
#' )$any
#'
#' @family Bounds Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperAtBounds <- function(x,
                              abs_bnd_tol = 1e-6,
                              rel_bnd_tol = 1e-4,
                              allowed_bounds = NULL) {
  pars <- OpenMx::omxGetParameters(model = x)
  nm <- names(x = pars)

  # Bounds aligned to pars by name.
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

  # Normalize and validate allowed bounds.
  if (is.null(x = allowed_bounds)) {
    allowed_bounds <- list(
      lower = character(length = 0),
      upper = character(length = 0)
    )
  } else {
    if (!is.list(x = allowed_bounds)) {
      stop(
        "allowed_bounds must be NULL or a list."
      )
    }

    allowed_names <- names(x = allowed_bounds)

    if (
      !is.null(x = allowed_names) &&
        any(
          !allowed_names %in% c(
            "lower",
            "upper"
          )
        )
    ) {
      stop(
        paste0(
          "allowed_bounds may only contain ",
          "'lower' and 'upper'."
        )
      )
    }

    if (is.null(x = allowed_bounds$lower)) {
      allowed_bounds$lower <- character(length = 0)
    }

    if (is.null(x = allowed_bounds$upper)) {
      allowed_bounds$upper <- character(length = 0)
    }

    if (
      !is.character(x = allowed_bounds$lower) ||
        anyNA(x = allowed_bounds$lower)
    ) {
      stop(
        paste0(
          "allowed_bounds$lower must be ",
          "a character vector without missing values."
        )
      )
    }

    if (
      !is.character(x = allowed_bounds$upper) ||
        anyNA(x = allowed_bounds$upper)
    ) {
      stop(
        paste0(
          "allowed_bounds$upper must be ",
          "a character vector without missing values."
        )
      )
    }

    allowed_bounds$lower <- unique(
      x = allowed_bounds$lower
    )

    allowed_bounds$upper <- unique(
      x = allowed_bounds$upper
    )

    unknown <- setdiff(
      x = unique(
        x = c(
          allowed_bounds$lower,
          allowed_bounds$upper
        )
      ),
      y = nm
    )

    if (length(x = unknown) > 0L) {
      stop(
        paste0(
          "Unknown parameter label(s) in allowed_bounds: ",
          paste(
            unknown,
            collapse = ", "
          ),
          "."
        )
      )
    }
  }

  close_to <- function(val,
                       bnd) {
    na_bnd <- is.na(x = bnd) | !is.finite(x = bnd)
    na_val <- is.na(x = val) | !is.finite(x = val)

    sc <- pmax(
      abs(x = val),
      abs(x = bnd),
      1
    )

    tol <- abs_bnd_tol + rel_bnd_tol * sc

    res <- (
      !na_bnd
    ) & (
      !na_val
    ) & (
      abs(
        x = val - bnd
      ) <= tol
    )

    res[is.na(x = res)] <- FALSE
    res
  }

  atlb <- close_to(
    val = pars,
    bnd = lb
  )

  atub <- close_to(
    val = pars,
    bnd = ub
  )

  # Raw bound status is retained.
  actionable_lb <- atlb
  actionable_ub <- atub

  # Allowed bound hits remain visible in at_lb / at_ub,
  # but they are not actionable.
  if (length(x = allowed_bounds$lower) > 0L) {
    actionable_lb[
      nm %in% allowed_bounds$lower
    ] <- FALSE
  }

  if (length(x = allowed_bounds$upper) > 0L) {
    actionable_ub[
      nm %in% allowed_bounds$upper
    ] <- FALSE
  }

  list(
    any = any(
      atlb | atub,
      na.rm = TRUE
    ),
    actionable = any(
      actionable_lb | actionable_ub,
      na.rm = TRUE
    ),
    at_lb = atlb,
    at_ub = atub,
    actionable_lb = actionable_lb,
    actionable_ub = actionable_ub
  )
}
