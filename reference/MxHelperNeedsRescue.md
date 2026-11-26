# Does the Fit Need a Rescue?

Tests whether a model needs another fit: its status code is missing or
not in `ok_codes`, it is not a good fit
([`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md)),
its Hessian is not positive definite
([`MxHelperHasPdHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md)),
or an estimate is at an actionable bound
([`MxHelperAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperAtBounds.md)).
When a test fails with an error, the answer is `TRUE`. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperNeedsRescue(
  model,
  grad_tol = 0.01,
  nd_tol = 1e-04,
  ok_codes = 0L,
  require_finite_fit = TRUE,
  hess_tol_abs = 1e-08,
  hess_tol_rel = 1e-10,
  check_condition = TRUE,
  cond_max = 1e+12,
  abs_bnd_tol = 1e-06,
  rel_bnd_tol = 1e-04,
  allowed_bounds = NULL
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

- abs_bnd_tol:

  Positive number. Absolute tolerance for an estimate at a bound.

- rel_bnd_tol:

  Positive number. Tolerance for an estimate at a bound, relative to the
  larger of the absolute estimate, the absolute bound, and 1.

- allowed_bounds:

  List or `NULL`. Parameters allowed to rest at a bound: a list with the
  character vectors `lower` and `upper` of parameter labels. Their bound
  hits are reported but are not actionable.

## Value

Returns `TRUE` or `FALSE`. The internal version returns `TRUE` when
`model` is not an OpenMx model.

## See also

Other Fit Diagnostics Functions:
[`MxHelperHasPdHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md),
[`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md),
[`MxHelperStatusCode()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperStatusCode.md)

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
MxHelperNeedsRescue(
  model = fit
)
#> [1] FALSE
```
