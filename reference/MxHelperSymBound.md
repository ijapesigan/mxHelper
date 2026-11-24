# Bounds of a Sym Matrix

Builds the lower or the upper bounds of a `p` by `p` symmetric matrix
from `NULL`, a single value, a vector, or a matrix. The lower triangle
is copied to the upper triangle. The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSymBound(p, val)
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

Other Symmetric Matrix Functions:
[`MxHelperSymFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymFree.md),
[`MxHelperSymLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymLabels.md),
[`MxHelperSymMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymMxMatrix.md),
[`MxHelperSymPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymPrepMatrices.md),
[`MxHelperSymValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSymBound(
  p = 2,
  val = 0
)
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
```
