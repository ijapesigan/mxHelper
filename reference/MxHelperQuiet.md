# Evaluate Quietly

Evaluates `expr` and drops its printed output and messages.
[`OpenMx::mxTryHard()`](https://rdrr.io/pkg/OpenMx/man/mxTryHard.html)
prints its progress and result even with `silent = TRUE`; this removes
both. Warnings are kept. The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperQuiet(expr, silent = TRUE)
```

## Arguments

- expr:

  R expression. Expression to evaluate.

- silent:

  Logical. If `TRUE`, drop the printed output and the messages of
  `expr`; if `FALSE`, evaluate `expr` as it is.

## Value

Returns the value of `expr`.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
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
MxHelperQuiet(
  expr = {
    message("dropped")
    1
  }
)
#> [1] 1
```
