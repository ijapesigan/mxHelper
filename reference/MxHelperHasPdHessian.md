# Is the Hessian Positive Definite?

Tests whether the Hessian of a fitted model is positive definite: its
smallest eigenvalue exceeds \\(\tau\_{\mathrm{abs}} +
\tau\_{\mathrm{rel}} \max \left( 1, \max\_{i} \left\| \lambda\_{i}
\right\| \right)\\). With `check_condition = TRUE`, its condition number
must also be at most `cond_max`. A missing Hessian counts as not
positive definite. The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperHasPdHessian(
  x,
  hess_tol_abs = 1e-08,
  hess_tol_rel = 1e-10,
  check_condition = FALSE,
  cond_max = 1e+12
)
```

## Arguments

- x:

  An OpenMx model (`MxModel`), usually fitted.

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

## Value

Returns `TRUE` or `FALSE`.

## See also

Other Fit Diagnostics Functions:
[`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md),
[`MxHelperNeedsRescue()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperNeedsRescue.md),
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
MxHelperHasPdHessian(
  x = fit
)
#> [1] TRUE
```
