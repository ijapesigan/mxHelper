# Starting Values of a Transition Matrix

Builds the starting values of the `p` by `p` transition matrix of a
discrete-time vector autoregressive model, projected so that every
eigenvalue is inside the unit circle
([`simStateSpace::ProjectToStability()`](https://jeksterslab.github.io/simStateSpace//reference/ProjectToStability.html)).
The arguments are checked first; the internal version, without checks,
is the one other projects copy.

## Usage

``` r
MxHelperDTVARBetaValues(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Transition matrix. If `NULL`,
  \\(0.001\\) times the identity.

## Value

Returns a numeric matrix.

## See also

Other Starting Values Functions:
[`MxHelperCTVARBetaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperCTVARBetaValues.md),
[`MxHelperDTVARAlphaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDTVARAlphaValues.md),
[`MxHelperSigmaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDTVARBetaValues(
  p = 2,
  val = c(0.5, 0, 0, 0.5)
)
#>      [,1] [,2]
#> [1,]  0.5  0.0
#> [2,]  0.0  0.5
```
