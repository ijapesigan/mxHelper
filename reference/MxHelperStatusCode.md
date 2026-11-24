# Status Code of a Fitted Model

Reads the OpenMx status code of a fitted model. Stops with an error when
the model has no single status code, and warns, with the status details,
when the code is not 0. The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperStatusCode(model, context = deparse(expr = substitute(expr = model)))
```

## Arguments

- model:

  An OpenMx model (`MxModel`).

- context:

  Character string. Name of the model in the messages. By default, the
  expression passed as `model`.

## Value

Returns the status code; the internal version returns it invisibly.

## See also

Other Fit Diagnostics Functions:
[`MxHelperHasPdHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md),
[`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md),
[`MxHelperNeedsRescue()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperNeedsRescue.md)

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
MxHelperStatusCode(
  model = fit
)
#> [1] 0
```
