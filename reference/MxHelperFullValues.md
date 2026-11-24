# Starting Values of a Full Matrix

Builds the starting values of an `m` by `n` matrix from `NULL`, a single
value, a vector, or a matrix. The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperFullValues(m, n, val)
```

## Arguments

- m:

  Positive integer. Number of rows.

- n:

  Positive integer. Number of columns.

- val:

  Numeric vector or matrix, or `NULL`. Values of the matrix. A single
  value is recycled; `NULL` means zeros.

## Value

Returns a numeric matrix.

## See also

Other Full Matrix Functions:
[`MxHelperFullBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullBound.md),
[`MxHelperFullFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFixed.md),
[`MxHelperFullFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFree.md),
[`MxHelperFullLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullLabels.md),
[`MxHelperFullMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullMxMatrix.md),
[`MxHelperFullPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullPrepMatrices.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperFullValues(
  m = 2,
  n = 2,
  val = c(1, 2, 3, 4)
)
#>      [,1] [,2]
#> [1,]    1    3
#> [2,]    2    4
```
