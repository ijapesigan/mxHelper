# Starting Values of a Diag Matrix

Builds the starting values of the diagonal of a `p` by `p` matrix from
`NULL`, a single value, a vector, or a matrix. Only the diagonal is
kept. The arguments are checked first; the internal version, without
checks, is the one other projects copy.

## Usage

``` r
MxHelperDiagValues(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Numeric vector or matrix, or `NULL`. Values of the matrix. A single
  value is recycled; `NULL` means zeros.

## Value

Returns a numeric vector of length `p`.

## See also

Other Diagonal Matrix Functions:
[`MxHelperDiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagBound.md),
[`MxHelperDiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagFree.md),
[`MxHelperDiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagLabels.md),
[`MxHelperDiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagMxMatrix.md),
[`MxHelperDiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagPrepMatrices.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDiagValues(
  p = 2,
  val = c(1, 2, 3, 4)
)
#> [1] 1 4
```
