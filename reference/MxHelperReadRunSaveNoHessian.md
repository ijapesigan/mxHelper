# Read, Fit without the Hessian, and Save a Model

Reads an OpenMx model from an `.rds` file, fits it without standard
errors or the Hessian
([`MxHelperRunNoHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRunNoHessian.md)),
and saves the fit to the same file. Errors and warnings are recorded,
not thrown. The arguments are checked first; the internal version,
without checks, is the one other projects copy.

## Usage

``` r
MxHelperReadRunSaveNoHessian(
  input,
  tries_explore = 1000,
  silent = FALSE,
  save_conditions = TRUE,
  muffle_warnings = TRUE
)
```

## Arguments

- input:

  Character string. Path of an `.rds` file that holds an OpenMx model.
  The fitted model is saved back to the same file.

- tries_explore:

  Positive integer. Extra tries of the wide and the local search.

- silent:

  Logical. If `TRUE`, suppress the progress output of OpenMx.

- save_conditions:

  Logical. If `TRUE`, an error is saved to `input` as attributes of the
  object read from it.

- muffle_warnings:

  Logical. If `TRUE`, warnings are recorded but not shown.

## Value

Returns the fitted model as read back from `input`. Warnings are in the
attribute `mx_fit_warnings`. On an error, the object in `input` (or an
empty list) with the attributes `mx_fit_error`, `mx_fit_error_call`, and
`mx_fit_error_time`.

## See also

Other Model Fitting Functions:
[`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
[`MxHelperForceHessianOptions()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperForceHessianOptions.md),
[`MxHelperMuSigma()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md),
[`MxHelperQuiet()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md),
[`MxHelperReadRunSave()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSave.md),
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
input <- tempfile(fileext = ".rds")
saveRDS(object = fit, file = input)
fit <- MxHelperQuiet(
  expr = MxHelperReadRunSaveNoHessian(
    input = input,
    tries_explore = 2,
    silent = TRUE
  )
)
```
