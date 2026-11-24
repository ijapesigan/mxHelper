# Free Elements of a Full Matrix

Builds which elements of an `m` by `n` matrix are free parameters from
`NULL`, a single value, a vector, or a matrix. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperFullFree(m, n, val)
```

## Arguments

- m:

  Positive integer. Number of rows.

- n:

  Positive integer. Number of columns.

- val:

  Logical vector or matrix, or `NULL`. Which elements are free
  parameters. A single value is recycled; `NULL` means all free.

## Value

Returns a logical matrix.

## See also

Other Full Matrix Functions:
[`MxHelperFullBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullBound.md),
[`MxHelperFullFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFixed.md),
[`MxHelperFullLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullLabels.md),
[`MxHelperFullMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullMxMatrix.md),
[`MxHelperFullPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullPrepMatrices.md),
[`MxHelperFullValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperFullFree(
  m = 2,
  n = 2,
  val = c(TRUE, FALSE, TRUE, TRUE)
)
#>       [,1] [,2]
#> [1,]  TRUE TRUE
#> [2,] FALSE TRUE
```
