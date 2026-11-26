# Is the Fit Good?

Tests whether a fitted model has a status code in `ok_codes`, a finite
fit value (with `require_finite_fit = TRUE`), and a largest absolute
gradient below `grad_tol`. A fit that fails the gradient test is still
good when its Newton decrement `g' H^{-1} g` is below `nd_tol` (`g` the
gradient, `H` the Hessian of the fit, positive definite): half of it is
what a Newton step would still gain in the fit value, so the test does
not depend on the scale of the parameters. Missing output counts as a
bad fit. The arguments are checked first; the internal version, without
checks, is the one other projects copy.

## Usage

``` r
MxHelperIsGoodFit(
  x,
  grad_tol = 0.01,
  ok_codes = 0L,
  require_finite_fit = TRUE,
  nd_tol = 1e-04
)
```

## Arguments

- x:

  An OpenMx model (`MxModel`), usually fitted.

- grad_tol:

  Positive number. Largest absolute gradient of a good fit.

- ok_codes:

  Integer vector. OpenMx status codes accepted as converged.

- require_finite_fit:

  Logical. If `TRUE`, a good fit needs a finite fit value.

- nd_tol:

  Non-negative number or `NULL`. Largest Newton decrement of a good fit,
  tested only when the gradient test fails and the fit has a positive
  definite Hessian. `NULL` or `0` switches this test off.

## Value

Returns `TRUE` or `FALSE`. `TRUE` has the attribute `criterion`:
`"gradient"` when the fit passes the gradient test, `"newton"` when it
passes only the Newton decrement test.

## See also

Other Fit Diagnostics Functions:
[`MxHelperHasPdHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md),
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
MxHelperIsGoodFit(
  x = fit
)
#> [1] TRUE
#> attr(,"criterion")
#> [1] "gradient"
```
