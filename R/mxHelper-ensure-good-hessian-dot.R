#' Fit a Model until Its Hessian Is Good (Internal)
#'
#' Fits the model until it is a good fit (`.MxHelperIsGoodFit()`) with a
#' positive definite Hessian (`.MxHelperHasPdHessian()`) and no estimate at
#' an actionable bound (`.MxHelperAtBounds()`), for at most `max_attempts`
#' attempts.
#' A model without output starts with a wide and a local search.
#' Each attempt runs the model, nudges estimates off actionable
#' bounds (`.MxHelperNudgeOffBounds()`), relaxes bounds that are hit
#' repeatedly or on the last attempt (`.MxHelperRelaxBoundsAtBounds()`),
#' starts a wide search when three attempts in a row do not
#' improve, and ends with a local search with a shrinking jitter.
#' The Hessian options are turned on first
#' (`.MxHelperForceHessianOptions()`).
#' Candidates are ranked by the criteria they meet, then by the
#' fit value; when the criteria are not met, the best candidate
#' is returned with a warning.
#' No input checks: see [MxHelperEnsureGoodHessian()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param tries_explore Positive integer.
#'   Extra tries of the wide search
#'   (`OpenMx::mxTryHardWideSearch()`).
#' @param tries_local Positive integer.
#'   Extra tries of the local search (`OpenMx::mxTryHard()`).
#' @param max_attempts Positive integer.
#'   Largest number of rescue attempts.
#' @param grad_tol Positive number.
#'   Largest absolute gradient of a good fit.
#' @param hess_tol_abs Positive number.
#'   Absolute tolerance on the smallest eigenvalue
#'   of the Hessian.
#' @param hess_tol_rel Positive number.
#'   Tolerance on the smallest eigenvalue of the Hessian,
#'   relative to its largest absolute eigenvalue.
#' @param check_condition Logical.
#'   If `TRUE`, the Hessian must also have a condition
#'   number of at most `cond_max`.
#' @param cond_max Positive number.
#'   Largest condition number of the Hessian.
#' @param abs_bnd_tol Positive number.
#'   Absolute tolerance for an estimate at a bound.
#' @param rel_bnd_tol Positive number.
#'   Tolerance for an estimate at a bound, relative to the
#'   larger of the absolute estimate, the absolute bound, and 1.
#' @param factor Number greater than 1.
#'   Factor by which a bound is moved away from zero.
#' @param relax_on_last Logical.
#'   If `TRUE`, relax the bounds of parameters at actionable
#'   bounds on the last attempt, or when the same bounds
#'   are hit `relax_streak` times in a row.
#' @param relax_exclude Character vector or `NULL`.
#'   Labels of parameters whose bounds are never relaxed.
#' @param protect_lb_zero Logical.
#'   If `TRUE`, a lower bound of zero is never relaxed.
#' @param ok_codes Integer vector.
#'   OpenMx status codes accepted as converged.
#' @param require_finite_fit Logical.
#'   If `TRUE`, a good fit needs a finite fit value.
#' @param rerun_code6 Logical.
#'   If `TRUE`, run again once after status code 6
#'   (not at a minimum), unless 6 is in `ok_codes`.
#' @param relax_streak Positive integer.
#'   Number of attempts in a row with the same actionable
#'   bound hits before the bounds are relaxed.
#' @param relax_min_attempt Positive integer.
#'   First attempt at which bounds may be relaxed.
#' @param silent Logical.
#'   If `TRUE`, suppress the progress output of OpenMx.
#' @param allowed_bounds List or `NULL`.
#'   Parameters allowed to rest at a bound:
#'   a list with the character vectors `lower` and `upper`
#'   of parameter labels.
#'   Their bound hits are reported but are not actionable.
#'
#' @return Returns an OpenMx model: the first that meets the criteria,
#'   or the best candidate. The internal version returns `model`
#'   unchanged when it is not an OpenMx model.
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
#' fit <- .MxHelperEnsureGoodHessian(
#'   model = fit
#' )
#' .MxHelperHasPdHessian(
#'   x = fit
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperEnsureGoodHessian <- function(model,
                                       tries_explore = 100,
                                       tries_local = 100,
                                       max_attempts = 10,
                                       grad_tol = 1e-2,
                                       hess_tol_abs = 1e-8,
                                       hess_tol_rel = 1e-10,
                                       check_condition = TRUE,
                                       cond_max = 1e12,
                                       abs_bnd_tol = 1e-6,
                                       rel_bnd_tol = 1e-4,
                                       factor = 10,
                                       relax_on_last = TRUE,
                                       relax_exclude = NULL,
                                       protect_lb_zero = TRUE,
                                       ok_codes = 0L,
                                       require_finite_fit = TRUE,
                                       rerun_code6 = TRUE,
                                       relax_streak = 3,
                                       relax_min_attempt = 3,
                                       silent = TRUE,
                                       allowed_bounds = NULL) {
  obj <- inherits(
    x = model,
    what = "MxModel"
  )

  out <- model
  if (isTRUE(x = obj)) {
    model <- .MxHelperForceHessianOptions(
      model = model
    )

    .Safe <- function(expr,
                      default) {
      tryCatch(
        expr = expr,
        error = function(e) {
          default
        }
      )
    }

    .Quiet <- function(expr) {
      .MxHelperQuiet(
        expr = expr,
        silent = silent
      )
    }

    .GetStatusCode <- function(x) {
      code <- .Safe(
        x$output$status$code,
        NA_integer_
      )
      # an unfitted model has no status code
      if (length(x = code) != 1L) {
        code <- NA_integer_
      }
      code
    }

    .GetFitValue <- function(x) {
      .Safe(
        x$output$fit,
        Inf
      )
    }

    .EmptyBd <- function() {
      list(
        any = FALSE,
        actionable = FALSE,
        at_lb = stats::setNames(
          object = logical(length = 0),
          nm = character(length = 0)
        ),
        at_ub = stats::setNames(
          object = logical(length = 0),
          nm = character(length = 0)
        ),
        actionable_lb = stats::setNames(
          object = logical(length = 0),
          nm = character(length = 0)
        ),
        actionable_ub = stats::setNames(
          object = logical(length = 0),
          nm = character(length = 0)
        )
      )
    }

    .Check <- function(x) {
      # Make .Check total:
      # never throw even if output is missing.
      has_output <- (
        inherits(
          x = x,
          what = "MxModel"
        ) &&
          !is.null(x = x$output)
      )

      if (!has_output) {
        out <- list(
          ok = FALSE,
          good_fit = FALSE,
          pd_hessian = FALSE,
          bd = .EmptyBd(),
          code = .GetStatusCode(x),
          fit = .GetFitValue(x)
        )
      } else {
        good_fit <- .Safe(
          .MxHelperIsGoodFit(
            x = x,
            grad_tol = grad_tol,
            ok_codes = ok_codes,
            require_finite_fit = require_finite_fit
          ),
          FALSE
        )

        pd_hessian <- .Safe(
          .MxHelperHasPdHessian(
            x = x,
            hess_tol_abs = hess_tol_abs,
            hess_tol_rel = hess_tol_rel,
            check_condition = check_condition,
            cond_max = cond_max
          ),
          FALSE
        )

        bd_obj <- .Safe(
          .MxHelperAtBounds(
            x = x,
            abs_bnd_tol = abs_bnd_tol,
            rel_bnd_tol = rel_bnd_tol,
            allowed_bounds = allowed_bounds
          ),
          .EmptyBd()
        )

        out <- list(
          ok = isTRUE(x = good_fit) &&
            isTRUE(x = pd_hessian) &&
            !isTRUE(
              x = bd_obj$actionable
            ),
          good_fit = good_fit,
          pd_hessian = pd_hessian,
          bd = bd_obj,
          code = .GetStatusCode(x),
          fit = .GetFitValue(x)
        )
      }
      out
    }

    .Rank <- function(chk) {
      if (isTRUE(x = chk$ok)) {
        0L
      } else if (
        isTRUE(x = chk$good_fit) &&
          isTRUE(x = chk$pd_hessian)
      ) {
        1L
      } else if (isTRUE(x = chk$good_fit)) {
        2L
      } else if (isTRUE(x = chk$pd_hessian)) {
        3L
      } else if (is.finite(x = chk$fit)) {
        4L
      } else {
        5L
      }
    }

    .Obj <- function(chk) {
      if (is.finite(x = chk$fit)) {
        chk$fit
      } else {
        Inf
      }
    }

    status_code <- .GetStatusCode(
      model
    )

    run <- (
      is.null(x = model$output) ||
        is.na(x = status_code) ||
        !(status_code %in% ok_codes)
    )

    if (!run) {
      chk0 <- .Check(
        model
      )

      run <- !isTRUE(
        x = chk0$ok
      )
    }

    out <- model
    if (run) {
      has_output <- (
        !is.null(x = model$output) &&
          !is.na(x = status_code)
      )

      fit <- model

      if (!has_output) {
        if (
          !isTRUE(x = silent) &&
            interactive()
        ) {
          cat(
            "\nNo valid output; starting wide exploration.\n"
          )
        }

        fit <- .Safe(
          .Quiet(
            OpenMx::mxTryHardWideSearch(
              model = fit,
              extraTries = tries_explore,
              checkHess = TRUE,
              silent = silent
            )
          ),
          fit
        )

        fit <- .Safe(
          .Quiet(
            OpenMx::mxTryHard(
              model = fit,
              extraTries = tries_local,
              silent = silent,
              jitterDistrib = "rnorm",
              scale = 0.05,
              checkHess = TRUE
            )
          ),
          fit
        )
      } else {
        if (
          !isTRUE(x = silent) &&
            interactive()
        ) {
          # nocov start
          cat(
            "\nStarting Hessian rescue from existing fit.\n"
          )
          # nocov end
        }
      }

      best_model <- fit
      best_chk <- .Check(
        fit
      )
      best_rank <- .Rank(
        best_chk
      )
      best_obj <- .Obj(
        best_chk
      )

      .UpdateBest <- function(candidate,
                              chk) {
        rk <- .Rank(
          chk
        )

        obj <- .Obj(
          chk
        )

        improved <- FALSE

        if (
          rk < best_rank ||
            (
              rk == best_rank &&
                obj < best_obj
            )
        ) {
          best_model <<- candidate
          best_chk <<- chk
          best_rank <<- rk
          best_obj <<- obj
          improved <- TRUE
        }

        improved
      }

      attempt <- 1L

      bd_streak <- 0L
      bd_last_labels <- character(length = 0)

      no_improve_streak <- 0L
      no_improve_max <- 3L

      repeat {
        # On error, continue from the best model so far.
        final <- .Safe(
          OpenMx::mxRun(
            model = fit,
            silent = silent
          ),
          best_model
        )

        if (isTRUE(x = rerun_code6)) {
          code_now <- .GetStatusCode(
            final
          )

          if (
            identical(
              x = code_now,
              y = 6L
            ) &&
              !(6L %in% ok_codes)
          ) {
            final <- .Safe(
              OpenMx::mxRun(
                model = final,
                silent = silent
              ),
              final
            )
          }
        }

        fit <- final
        chk <- .Check(
          final
        )

        if (
          .UpdateBest(
            candidate = final,
            chk = chk
          )
        ) {
          no_improve_streak <- 0L
        } else {
          no_improve_streak <- no_improve_streak + 1L
        }

        if (isTRUE(x = chk$ok)) {
          out <- final
          break
        }

        if (attempt >= max_attempts) {
          warning(
            paste0(
              "Rescue did not meet criteria after ",
              max_attempts,
              " attempts; returning best candidate encountered."
            )
          )

          out <- best_model
          break
        }

        # Track only ACTIONABLE repeated bound hits.
        if (isTRUE(x = chk$bd$actionable)) {
          bd_labels <- unique(
            x = c(
              names(
                x = chk$bd$actionable_lb
              )[
                chk$bd$actionable_lb
              ],
              names(
                x = chk$bd$actionable_ub
              )[
                chk$bd$actionable_ub
              ]
            )
          )

          bd_labels <- bd_labels[
            !is.na(x = bd_labels)
          ]

          if (
            identical(
              x = bd_labels,
              y = bd_last_labels
            )
          ) {
            bd_streak <- bd_streak + 1L
          } else {
            bd_streak <- 1L
          }

          bd_last_labels <- bd_labels
        } else {
          bd_streak <- 0L
          bd_last_labels <- character(length = 0)
        }

        relax_now <- isTRUE(
          x = relax_on_last
        ) && (
          attempt == (
            max_attempts - 1L
          ) ||
            (
              isTRUE(
                x = chk$bd$actionable
              ) &&
                attempt >= relax_min_attempt &&
                bd_streak >= relax_streak
            )
        )

        if (
          isTRUE(x = relax_now) &&
            isTRUE(
              x = chk$bd$actionable
            )
        ) {
          if (
            !isTRUE(x = silent) &&
              interactive()
          ) {
            # nocov start
            cat(
              "\nRelaxing bounds for parameters at actionable bounds.\n"
            )
            # nocov end
          }

          fit <- .Safe(
            .MxHelperRelaxBoundsAtBounds(
              x = fit,
              factor = factor,
              abs_bnd_tol = abs_bnd_tol,
              rel_bnd_tol = rel_bnd_tol,
              exclude = relax_exclude,
              protect_lb_zero = protect_lb_zero,
              allowed_bounds = allowed_bounds
            ),
            fit
          )

          fit <- .Safe(
            .Quiet(
              OpenMx::mxTryHardWideSearch(
                model = fit,
                extraTries = tries_explore,
                checkHess = TRUE,
                silent = silent
              )
            ),
            best_model
          )

          # Recompute after relaxation/search.
          chk <- .Check(
            fit
          )

          .UpdateBest(
            candidate = fit,
            chk = chk
          )

          no_improve_streak <- 0L
        }

        # Nudge only actionable bound hits.
        if (isTRUE(x = chk$bd$actionable)) {
          if (
            !isTRUE(x = silent) &&
              interactive()
          ) {
            # nocov start
            cat(
              "\nNudging parameter estimates off actionable bounds.\n"
            )
            # nocov end
          }

          fit <- .Safe(
            .MxHelperNudgeOffBounds(
              x = fit,
              abs_bnd_tol = abs_bnd_tol,
              rel_bnd_tol = rel_bnd_tol,
              mult = 10,
              allowed_bounds = allowed_bounds
            ),
            fit
          )
        }

        # If optimization has stalled, kick a wide search.
        if (
          no_improve_streak >= no_improve_max
        ) {
          fit <- .Safe(
            .Quiet(
              OpenMx::mxTryHardWideSearch(
                model = fit,
                extraTries = tries_explore,
                checkHess = TRUE,
                silent = silent
              )
            ),
            best_model
          )

          chk <- .Check(
            fit
          )

          .UpdateBest(
            candidate = fit,
            chk = chk
          )

          no_improve_streak <- 0L
        }

        local_scale <- 0.05 / (
          attempt + 1
        )

        fit <- .Safe(
          .Quiet(
            OpenMx::mxTryHard(
              model = fit,
              extraTries = tries_local,
              silent = silent,
              jitterDistrib = "rnorm",
              scale = local_scale,
              checkHess = TRUE
            )
          ),
          best_model
        )

        attempt <- attempt + 1L
      }
    }
  }
  out
}
