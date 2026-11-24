# Free Elements of a Sdiag Matrix

Builds which elements of a `p` by `p` strictly lower triangular matrix
are free parameters from `NULL`, a single value, a vector, or a matrix.
The diagonal and the upper triangle are never free. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperSdiagFree(p, val)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- val:

  Logical vector or matrix, or `NULL`. Which elements are free
  parameters. A single value is recycled; `NULL` means all free.

## Value

Returns a logical matrix.

## See also

Other Strictly Lower Triangular Matrix Functions:
[`MxHelperSdiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagBound.md),
[`MxHelperSdiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagLabels.md),
[`MxHelperSdiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagMxMatrix.md),
[`MxHelperSdiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagPrepMatrices.md),
[`MxHelperSdiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSdiagFree(
  p = 2,
  val = c(TRUE, FALSE, TRUE, TRUE)
)
#>       [,1]  [,2]
#> [1,] FALSE FALSE
#> [2,] FALSE FALSE
```
