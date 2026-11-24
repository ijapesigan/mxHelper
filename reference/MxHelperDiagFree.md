# Free Elements of a Diag Matrix

Builds which elements of the diagonal of a `p` by `p` matrix are free
parameters from `NULL`, a single value, a vector, or a matrix. Only the
diagonal is kept. The arguments are checked first; the internal version,
without checks, is the one other projects copy.

## Usage

``` r
MxHelperDiagFree(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Logical vector or matrix, or `NULL`. Which elements are free
  parameters. A single value is recycled; `NULL` means all free.

## Value

Returns a logical vector of length `p`.

## See also

Other Diagonal Matrix Functions:
[`MxHelperDiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagBound.md),
[`MxHelperDiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagLabels.md),
[`MxHelperDiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagMxMatrix.md),
[`MxHelperDiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagPrepMatrices.md),
[`MxHelperDiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDiagFree(
  p = 2,
  val = c(TRUE, FALSE, TRUE, TRUE)
)
#> [1] TRUE TRUE
```
