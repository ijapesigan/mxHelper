# Bounds of a Full Matrix

Builds the lower or the upper bounds of an `m` by `n` matrix from
`NULL`, a single value, a vector, or a matrix. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperFullBound(m, n, val)
```

## Arguments

- m:

  Positive integer. Number of rows.

- n:

  Positive integer. Number of columns.

- val:

  Numeric vector or matrix, or `NULL`. Bounds of the matrix. A single
  value is recycled; `NULL` or `NA` means none.

## Value

Returns a numeric matrix, with `NA` where there is no bound.

## See also

Other Full Matrix Functions:
[`MxHelperFullFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFixed.md),
[`MxHelperFullFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFree.md),
[`MxHelperFullLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullLabels.md),
[`MxHelperFullMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullMxMatrix.md),
[`MxHelperFullPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullPrepMatrices.md),
[`MxHelperFullValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperFullBound(
  m = 2,
  n = 2,
  val = 0
)
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
```
