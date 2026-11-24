# Bounds of a Diag Matrix

Builds the lower or the upper bounds of the diagonal of a `p` by `p`
matrix from `NULL`, a single value, a vector, or a matrix. Only the
diagonal is kept. The arguments are checked first; the internal version,
without checks, is the one other projects copy.

## Usage

``` r
MxHelperDiagBound(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Bounds of the matrix. A single
  value is recycled; `NULL` or `NA` means none.

## Value

Returns a numeric vector of length `p`, with `NA` where there is no
bound.

## See also

Other Diagonal Matrix Functions:
[`MxHelperDiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagFree.md),
[`MxHelperDiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagLabels.md),
[`MxHelperDiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagMxMatrix.md),
[`MxHelperDiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagPrepMatrices.md),
[`MxHelperDiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDiagBound(
  p = 2,
  val = 0
)
#> [1] 0 0
```
