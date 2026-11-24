# Starting Values of a Sdiag Matrix

Builds the starting values of a `p` by `p` strictly lower triangular
matrix from `NULL`, a single value, a vector, or a matrix. The diagonal
and the upper triangle are set to the value of a fixed element. The
arguments are checked first; the internal version, without checks, is
the one other projects copy.

## Usage

``` r
MxHelperSdiagValues(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Values of the matrix. A single
  value is recycled; `NULL` means zeros.

## Value

Returns a numeric matrix.

## See also

Other Strictly Lower Triangular Matrix Functions:
[`MxHelperSdiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagBound.md),
[`MxHelperSdiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagFree.md),
[`MxHelperSdiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagLabels.md),
[`MxHelperSdiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagMxMatrix.md),
[`MxHelperSdiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagPrepMatrices.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSdiagValues(
  p = 2,
  val = c(1, 2, 3, 4)
)
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    2    0
```
