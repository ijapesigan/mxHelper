# Bounds of a Sdiag Matrix

Builds the lower or the upper bounds of a `p` by `p` strictly lower
triangular matrix from `NULL`, a single value, a vector, or a matrix.
The diagonal and the upper triangle have no bounds. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperSdiagBound(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Bounds of the matrix. A single
  value is recycled; `NULL` or `NA` means none.

## Value

Returns a numeric matrix, with `NA` where there is no bound.

## See also

Other Strictly Lower Triangular Matrix Functions:
[`MxHelperSdiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagFree.md),
[`MxHelperSdiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagLabels.md),
[`MxHelperSdiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagMxMatrix.md),
[`MxHelperSdiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagPrepMatrices.md),
[`MxHelperSdiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSdiagBound(
  p = 2,
  val = c(0, -1, 0, 0)
)
#>      [,1] [,2]
#> [1,]   NA   NA
#> [2,]   -1   NA
```
