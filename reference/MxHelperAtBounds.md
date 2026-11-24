# Which Estimates Are at a Bound?

Finds the free parameters whose estimates are at their lower or upper
bound, within \\(\tau\_{\mathrm{abs}} + \tau\_{\mathrm{rel}} \max \left(
\left\| \hat{\theta} \right\|, \left\| b \right\|, 1 \right)\\). A hit
is actionable unless the parameter is listed in `allowed_bounds` for
that side. The arguments are checked first; the internal version,
without checks, is the one other projects copy.

## Usage

``` r
MxHelperAtBounds(
  x,
  abs_bnd_tol = 1e-06,
  rel_bnd_tol = 1e-04,
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

- allowed_bounds:

  List or `NULL`. Parameters allowed to rest at a bound: a list with the
  character vectors `lower` and `upper` of parameter labels. Their bound
  hits are reported but are not actionable.

## Value

Returns a list with the elements

- any:

  `TRUE` if any estimate is at a bound.

- actionable:

  `TRUE` if any hit is actionable.

- at_lb, at_ub:

  Named logical vectors: at the lower, at the upper bound.

- actionable_lb, actionable_ub:

  The same, actionable hits only.

## See also

Other Bounds Functions:
[`MxHelperNudgeOffBounds()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperNudgeOffBounds.md),
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
MxHelperAtBounds(
  x = fit
)$any
#> [1] FALSE
```
