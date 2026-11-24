# Turn on the Hessian

Sets the OpenMx options `Calculate Hessian` and `Hessian` of the model
to `"Yes"`, so that a fit computes the Hessian. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperForceHessianOptions(model)
```

## Arguments

- model:

  An OpenMx model (`MxModel`).

## Value

Returns the model with the two options set.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
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
model <- OpenMx::mxModel(model = "m")
model <- MxHelperForceHessianOptions(
  model = model
)
model@options
#> $`Calculate Hessian`
#> [1] "Yes"
#> 
#> $Hessian
#> [1] "Yes"
#> 
```
