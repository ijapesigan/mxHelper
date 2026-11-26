# Read, Fit, and Save a Model

Reads an OpenMx model from an `.rds` file, fits it
([`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
or
[`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html)
with `check_hess = FALSE`), and saves the fit to the same file, for
simulations that keep each replication in its own file. Errors and
warnings are recorded, not thrown. The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperReadRunSave(
  input,
  tries_explore = 100,
  tries_local = 100,
  max_attempts = 10,
  grad_tol = 0.01,
  nd_tol = 1e-04,
  hess_tol_abs = 1e-08,
  hess_tol_rel = 1e-10,
  check_condition = FALSE,
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
  silent = FALSE,
  check_hess = TRUE,
  save_conditions = TRUE,
  muffle_warnings = TRUE
)
```

## Arguments

- input:

  Character string. Path of an `.rds` file that holds an OpenMx model.
  The fitted model is saved back to the same file.

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

- check_hess:

  Logical. If `TRUE`, fit with the Hessian rescue (`EnsureGoodHessian`);
  if `FALSE`, with
  [`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html)
  only.

- save_conditions:

  Logical. If `TRUE`, an error is saved to `input` as attributes of the
  object read from it.

- muffle_warnings:

  Logical. If `TRUE`, warnings are recorded but not shown.

## Value

Returns the fitted model as read back from `input`. Warnings are in the
attribute `mx_fit_warnings`. On an error, the object in `input` (or an
empty list) with the attributes `mx_fit_error`, `mx_fit_error_call`, and
`mx_fit_error_time`.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
[`MxHelperQuiet()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md),
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
input <- tempfile(fileext = ".rds")
saveRDS(object = fit, file = input)
fit <- MxHelperReadRunSave(
  input = input,
  silent = TRUE
)
```
