# Relax the Bounds That Estimates Are at

Moves each finite bound that an estimate is at
([`MxHelperAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperAtBounds.md))
away from zero by `factor`: a negative bound is multiplied by it, a
positive one divided. When the new bounds of a parameter cross, they are
set around their midpoint. Unlike
[`MxHelperRelaxBoundsAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRelaxBoundsAtBounds.md),
it ignores `allowed_bounds` and relaxes a lower bound of zero unchanged
(zero stays zero). The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperRelaxBounds(
  x,
  factor = 10,
  abs_bnd_tol = 1e-06,
  rel_bnd_tol = 1e-04,
  labels = NULL,
  exclude = NULL
)
```

## Arguments

- x:

  An OpenMx model (`MxModel`), usually fitted.

- factor:

  Number greater than 1. Factor by which a bound is moved away from
  zero.

- abs_bnd_tol:

  Positive number. Absolute tolerance for an estimate at a bound.

- rel_bnd_tol:

  Positive number. Tolerance for an estimate at a bound, relative to the
  larger of the absolute estimate, the absolute bound, and 1.

- labels:

  Character vector or `NULL`. Labels of the only parameters whose bounds
  may be relaxed. If `NULL`, all.

- exclude:

  Character vector or `NULL`. Labels of parameters whose bounds are
  never relaxed.

## Value

Returns the model with the new bounds.

## See also

Other Bounds Functions:
[`MxHelperAtBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperAtBounds.md),
[`MxHelperNudgeOffBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperNudgeOffBounds.md),
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
fit <- MxHelperRelaxBounds(
  x = fit
)
```
