# Move Estimates off Their Bounds

Moves each estimate at an actionable bound
([`MxHelperAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperAtBounds.md))
inward by `mult` times the bound tolerance, without crossing the
opposite bound. Other estimates are unchanged. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperNudgeOffBounds(
  x,
  abs_bnd_tol = 1e-06,
  rel_bnd_tol = 1e-04,
  mult = 10,
  allowed_bounds = NULL
)
```

## Arguments

- x:

  An OpenMx model (`MxModel`), usually fitted.

- abs_bnd_tol:

  Positive number. Absolute tolerance for an estimate at a bound.

- rel_bnd_tol:

  Positive number. Tolerance for an estimate at a bound, relative to the
  larger of the absolute estimate, the absolute bound, and 1.

- mult:

  Positive number. Multiple of the bound tolerance by which an estimate
  is moved inward.

- allowed_bounds:

  List or `NULL`. Parameters allowed to rest at a bound: a list with the
  character vectors `lower` and `upper` of parameter labels. Their bound
  hits are reported but are not actionable.

## Value

Returns the model with the new values.

## See also

Other Bounds Functions:
[`MxHelperAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperAtBounds.md),
[`MxHelperRelaxBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRelaxBounds.md),
[`MxHelperRelaxBoundsAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRelaxBoundsAtBounds.md)

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
fit <- MxHelperNudgeOffBounds(
  x = fit
)
```
