# Starting Values of a Sym Matrix

Builds the starting values of a `p` by `p` symmetric matrix from `NULL`,
a single value, a vector, or a matrix. The lower triangle is copied to
the upper triangle. The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSymValues(p, val)
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

Other Symmetric Matrix Functions:
[`MxHelperSymBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymBound.md),
[`MxHelperSymFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymFree.md),
[`MxHelperSymLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymLabels.md),
[`MxHelperSymMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymMxMatrix.md),
[`MxHelperSymPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymPrepMatrices.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSymValues(
  p = 2,
  val = c(1, 2, 3, 4)
)
#>      [,1] [,2]
#> [1,]    1    2
#> [2,]    2    4
```
