# Free Elements of a Sym Matrix

Builds which elements of a `p` by `p` symmetric matrix are free
parameters from `NULL`, a single value, a vector, or a matrix. The lower
triangle is copied to the upper triangle. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperSymFree(p, val)
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

Other Symmetric Matrix Functions:
[`MxHelperSymBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymBound.md),
[`MxHelperSymLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymLabels.md),
[`MxHelperSymMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymMxMatrix.md),
[`MxHelperSymPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymPrepMatrices.md),
[`MxHelperSymValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSymFree(
  p = 2,
  val = c(TRUE, FALSE, TRUE, TRUE)
)
#>       [,1]  [,2]
#> [1,]  TRUE FALSE
#> [2,] FALSE  TRUE
```
