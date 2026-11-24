# Robust Standard Errors

Computes robust (sandwich) standard errors of a fitted model with
[`OpenMx::imxRobustSE()`](https://rdrr.io/pkg/OpenMx/man/imxRobustSE.html),
quietly. On an error, it returns `NULL`. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperRobustSE(model)
```

## Arguments

- model:

  An OpenMx model (`MxModel`), usually fitted.

## Value

Returns the list of
[`OpenMx::imxRobustSE()`](https://rdrr.io/pkg/OpenMx/man/imxRobustSE.html)
with `details = TRUE` (`SE`, `cov`, `bread`, `meat`, `TIC`), or `NULL`.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
[`MxHelperQuiet()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md),
[`MxHelperReadRunSave()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSave.md),
[`MxHelperReadRunSaveNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSaveNoHessian.md),
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
MxHelperRobustSE(
  model = fit
)$SE
#>  FIML.l[1,1]  FIML.l[2,1]  FIML.l[2,2] FIML.mu[1,1] FIML.mu[1,2] 
#>   0.10849083   0.13985675   0.09329834   0.16284481   0.13081303 
```
