# Starting Values of an Intercept Vector

Builds the starting values of the `p` by 1 intercept vector of a
discrete-time vector autoregressive model. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperDTVARAlphaValues(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Intercept column vector. If
  `NULL`, zeros.

## Value

Returns a `p` by 1 numeric matrix.

## See also

Other Starting Values Functions:
[`MxHelperCTVARBetaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperCTVARBetaValues.md),
[`MxHelperDTVARBetaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDTVARBetaValues.md),
[`MxHelperSigmaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDTVARAlphaValues(
  p = 2,
  val = NULL
)
#>      [,1]
#> [1,]    0
#> [2,]    0
```
