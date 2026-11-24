# Fit the Saturated Model

Fits the saturated model (means and covariances) to the data by full
information maximum likelihood, with
[`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html).
The covariance matrix is \\(\boldsymbol{L} \boldsymbol{L}^{\prime}\\),
with \\(\boldsymbol{L}\\) lower triangular and its diagonal bounded
below by \\(10^{-6}\\); its starting value is the Cholesky factor of the
pairwise covariance matrix, made positive definite first. The arguments
are checked first; the internal version, without checks, is the one
other projects copy.

## Usage

``` r
MxHelperMuSigma(x, ...)
```

## Arguments

- x:

  Data frame or numeric matrix. Observed variables in columns, with
  column names. Missing values are allowed (full information ML).

- ...:

  Further arguments to
  [`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html).

## Value

Returns a fitted OpenMx model named `FIML`, with the matrices `l`, `mu`,
and the algebra `sigma`.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
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
OpenMx::mxEval(
  expression = sigma,
  model = fit
)
#>            [,1]       [,2]
#> [1,]  1.2993799 -0.2495024
#> [2,] -0.2495024  0.8384815
```
