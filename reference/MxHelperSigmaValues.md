# Starting Values of a Covariance Matrix

Builds the starting values of a `p` by `p` covariance matrix. When an
eigenvalue is at most \\(10^{-6}\\), the matrix is replaced by the
nearest positive semidefinite matrix
([`Matrix::nearPD()`](https://rdrr.io/pkg/Matrix/man/nearPD.html)). The
arguments are checked first; the internal version, without checks, is
the one other projects copy.

## Usage

``` r
MxHelperSigmaValues(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Covariance matrix. If `NULL`, the
  identity.

## Value

Returns a numeric matrix.

## See also

Other Starting Values Functions:
[`MxHelperCTVARBetaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperCTVARBetaValues.md),
[`MxHelperDTVARAlphaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDTVARAlphaValues.md),
[`MxHelperDTVARBetaValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDTVARBetaValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSigmaValues(
  p = 2,
  val = c(1, 0.5, 0.5, 1)
)
#>      [,1] [,2]
#> [1,]  1.0  0.5
#> [2,]  0.5  1.0
```
