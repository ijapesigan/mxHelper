# Fit a Model without the Hessian

Fits the model without standard errors or the Hessian
([`MxHelperStripHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperStripHessian.md)):
a wide search
([`OpenMx::mxTryHardWideSearch()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html)),
then a local search
([`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html))
with normal jitter of scale 0.05, each with `tries_explore` extra tries.
The arguments are checked first; the internal version, without checks,
is the one other projects copy.

## Usage

``` r
MxHelperRunNoHessian(model, tries_explore, silent)
```

## Arguments

- model:

  An OpenMx model (`MxModel`).

- tries_explore:

  Positive integer. Extra tries of the wide and the local search.

- silent:

  Logical. If `TRUE`, suppress the progress output of OpenMx.

## Value

Returns the fitted OpenMx model.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
[`MxHelperQuiet()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md),
[`MxHelperReadRunSave()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSave.md),
[`MxHelperReadRunSaveNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSaveNoHessian.md),
[`MxHelperRobustSE()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRobustSE.md),
[`MxHelperRun()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRun.md),
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
fit <- MxHelperQuiet(
  expr = MxHelperRunNoHessian(
    model = fit,
    tries_explore = 2,
    silent = TRUE
  )
)
```
