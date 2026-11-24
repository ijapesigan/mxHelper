# Turn off the Hessian

Turns off standard errors and the Hessian of a model: the option
`Standard Errors` is set to `"No"`, and the steps that compute standard
errors, the Hessian, or numerical derivatives are removed from the
compute plan. A model without a compute plan gets a minimal one
(gradient descent, then the fit). The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperStripHessian(model)
```

## Arguments

- model:

  An OpenMx model (`MxModel`).

## Value

Returns the model without standard error or Hessian steps.

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
[`MxHelperRunNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRunNoHessian.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
model <- OpenMx::mxModel(model = "m")
model <- MxHelperStripHessian(
  model = model
)
class(x = model@compute)
#> [1] "MxComputeSequence"
#> attr(,"package")
#> [1] "OpenMx"
```
