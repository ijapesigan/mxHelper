# Starting Values of a Drift Matrix

Builds the starting values of the `p` by `p` drift matrix of a
continuous-time vector autoregressive model, projected so that every
eigenvalue has a negative real part
([`simStateSpace::ProjectToHurwitz()`](https://jeksterslab.github.io/simStateSpace//reference/ProjectToHurwitz.html)).
The arguments are checked first; the internal version, without checks,
is the one other projects copy.

## Usage

``` r
MxHelperCTVARBetaValues(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Drift matrix. If `NULL`,
  \\(-0.1\\) times the identity.

## Value

Returns a numeric matrix.

## See also

Other Starting Values Functions:
[`MxHelperDTVARAlphaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDTVARAlphaValues.md),
[`MxHelperDTVARBetaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDTVARBetaValues.md),
[`MxHelperSigmaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperCTVARBetaValues(
  p = 2,
  val = NULL
)
#>      [,1] [,2]
#> [1,] -0.1  0.0
#> [2,]  0.0 -0.1
```
