# Fit a Model Unless It Is Already Good

Fits the model with
[`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html),
accepting status codes 0, 1, 5, and 6, unless it is already a good fit
([`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md))
with a positive definite Hessian
([`MxHelperHasPdHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md)).
On an error, the input model is returned. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperRun(
  model,
  grad_tol = 0.01,
  nd_tol = 1e-04,
  ok_codes = 0L,
  require_finite_fit = TRUE,
  hess_tol_abs = 1e-08,
  hess_tol_rel = 1e-10,
  check_condition = FALSE,
  cond_max = 1e+12,
  silent = FALSE,
  ...
)
```

## Arguments

- model:

  An OpenMx model (`MxModel`).

- grad_tol:

  Positive number. Largest absolute gradient of a good fit.

- nd_tol:

  Non-negative number or `NULL`. Largest Newton decrement of a good fit:
  a fit that fails `grad_tol` is still good when `g' H^{-1} g < nd_tol`,
  with `g` the gradient and `H` the Hessian (positive definite) of the
  fit. `NULL` or `0` switches this test off.

- ok_codes:

  Integer vector. OpenMx status codes accepted as converged.

- require_finite_fit:

  Logical. If `TRUE`, a good fit needs a finite fit value.

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

- silent:

  Logical. If `TRUE`, suppress the progress output of OpenMx.

- ...:

  Further arguments to
  [`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html).

## Value

Returns an OpenMx model. The internal version returns `NULL` when
`model` is not an OpenMx model.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
[`MxHelperQuiet()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md),
[`MxHelperReadRunSave()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSave.md),
[`MxHelperReadRunSaveNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSaveNoHessian.md),
[`MxHelperRobustSE()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRobustSE.md),
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
fit <- MxHelperRun(
  model = fit
)
fit$output$status$code
#> [1] 0
```
