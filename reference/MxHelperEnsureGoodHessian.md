# Fit a Model until Its Hessian Is Good

Fits the model until it is a good fit
([`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md))
with a positive definite Hessian
([`MxHelperHasPdHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md))
and no estimate at an actionable bound
([`MxHelperAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperAtBounds.md)),
for at most `max_attempts` attempts. A model without output starts with
a wide and a local search. Each attempt runs the model, nudges estimates
off actionable bounds
([`MxHelperNudgeOffBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperNudgeOffBounds.md)),
relaxes bounds that are hit repeatedly or on the last attempt
([`MxHelperRelaxBoundsAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRelaxBoundsAtBounds.md)),
starts a wide search when three attempts in a row do not improve, and
ends with a local search with a shrinking jitter. The Hessian options
are turned on first
([`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md)).
Candidates are ranked by the criteria they meet, then by the fit value;
when the criteria are not met, the best candidate is returned with a
warning. The arguments are checked first; the internal version, without
checks, is the one other projects copy.

## Usage

``` r
MxHelperEnsureGoodHessian(
  model,
  tries_explore = 100,
  tries_local = 100,
  max_attempts = 10,
  grad_tol = 0.01,
  nd_tol = 1e-04,
  hess_tol_abs = 1e-08,
  hess_tol_rel = 1e-10,
  check_condition = TRUE,
  cond_max = 1e+12,
  abs_bnd_tol = 1e-06,
  rel_bnd_tol = 1e-04,
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
  allowed_bounds = NULL
)
```

## Arguments

- model:

  An OpenMx model (`MxModel`).

- tries_explore:

  Positive integer. Extra tries of the wide search
  ([`OpenMx::mxTryHardWideSearch()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html)).

- tries_local:

  Positive integer. Extra tries of the local search
  ([`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html)).

- max_attempts:

  Positive integer. Largest number of rescue attempts.

- grad_tol:

  Positive number. Largest absolute gradient of a good fit.

- nd_tol:

  Non-negative number or `NULL`. Largest Newton decrement of a good fit:
  a fit that fails `grad_tol` is still good when `g' H^{-1} g < nd_tol`,
  with `g` the gradient and `H` the Hessian (positive definite) of the
  fit. `NULL` or `0` switches this test off.

- hess_tol_abs:

  Positive number. Absolute tolerance on the smallest eigenvalue of the
  Hessian.

- hess_tol_rel:

  Positive number. Tolerance on the smallest eigenvalue of the Hessian,
  relative to its largest absolute eigenvalue.

- check_condition:

  Logical. If `TRUE`, the Hessian must also have a condition number of
  at most `cond_max`.

- cond_max:

  Positive number. Largest condition number of the Hessian.

- abs_bnd_tol:

  Positive number. Absolute tolerance for an estimate at a bound.

- rel_bnd_tol:

  Positive number. Tolerance for an estimate at a bound, relative to the
  larger of the absolute estimate, the absolute bound, and 1.

- factor:

  Number greater than 1. Factor by which a bound is moved away from
  zero.

- relax_on_last:

  Logical. If `TRUE`, relax the bounds of parameters at actionable
  bounds on the last attempt, or when the same bounds are hit
  `relax_streak` times in a row.

- relax_exclude:

  Character vector or `NULL`. Labels of parameters whose bounds are
  never relaxed.

- protect_lb_zero:

  Logical. If `TRUE`, a lower bound of zero is never relaxed.

- ok_codes:

  Integer vector. OpenMx status codes accepted as converged.

- require_finite_fit:

  Logical. If `TRUE`, a good fit needs a finite fit value.

- rerun_code6:

  Logical. If `TRUE`, run again once after status code 6 (not at a
  minimum), unless 6 is in `ok_codes`.

- relax_streak:

  Positive integer. Number of attempts in a row with the same actionable
  bound hits before the bounds are relaxed.

- relax_min_attempt:

  Positive integer. First attempt at which bounds may be relaxed.

- silent:

  Logical. If `TRUE`, suppress the progress output of OpenMx.

- allowed_bounds:

  List or `NULL`. Parameters allowed to rest at a bound: a list with the
  character vectors `lower` and `upper` of parameter labels. Their bound
  hits are reported but are not actionable.

## Value

Returns an OpenMx model: the first that meets the criteria, or the best
candidate. The internal version returns `model` unchanged when it is not
an OpenMx model.

## See also

Other Model Fitting Functions:
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
[`MxHelperQuiet()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md),
[`MxHelperReadRunSave()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSave.md),
[`MxHelperReadRunSaveNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSaveNoHessian.md),
[`MxHelperRobustSE()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRobustSE.md),
[`MxHelperRun()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRun.md),
[`MxHelperRunNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRunNoHessian.md),
[`MxHelperStripHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperStripHessian.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
set.seed(seed = 42)
x <- data.frame(
  y1 = rnorm(n = 50),
  y2 = rnorm(n = 50)
)
fit <- MxHelperQuiet(
  expr = MxHelperMuSigma(
    x = x,
    extraTries = 2
  )
)
fit <- MxHelperEnsureGoodHessian(
  model = fit
)
MxHelperHasPdHessian(
  x = fit
)
#> [1] TRUE
```
