# Arguments of a Full OpenMx Matrix

Builds the free elements, values, labels, and bounds of an `m` by `n`
matrix for
[`OpenMx::mxMatrix()`](https://rdrr.io/pkg/OpenMx/man/mxMatrix.html).
Labels and bounds of fixed elements are set to `NA`. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperFullPrepMatrices(
  m,
  n,
  free_val,
  values,
  lbound_val,
  ubound_val,
  vec,
  name
)
```

## Arguments

- m:

  Positive integer. Number of rows.

- n:

  Positive integer. Number of columns.

- free_val:

  Logical vector or matrix, or `NULL`. Which elements are free
  parameters. A single value is recycled; `NULL` means all free.

- values:

  Numeric vector or matrix, or `NULL`. Starting values. A single value
  is recycled; `NULL` means zeros.

- lbound_val:

  Numeric vector or matrix, or `NULL`. Lower bounds of the free
  elements. A single value is recycled; `NULL` or `NA` means none.

- ubound_val:

  Numeric vector or matrix, or `NULL`. Upper bounds of the free
  elements. A single value is recycled; `NULL` or `NA` means none.

- vec:

  Logical. If `TRUE`, also return the bracket labels of the free
  elements, for a column vector of free parameters.

- name:

  Character string. Name of the matrix or algebra.

## Value

Returns a list with the elements `free`, `values`, `labels`, `lbound`,
`ubound`, and `vec` (the bracket labels of the free elements, or `FALSE`
when `vec = FALSE`).

## See also

Other Full Matrix Functions:
[`MxHelperFullBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullBound.md),
[`MxHelperFullFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFixed.md),
[`MxHelperFullFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFree.md),
[`MxHelperFullLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullLabels.md),
[`MxHelperFullMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullMxMatrix.md),
[`MxHelperFullValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperFullPrepMatrices(
  m = 2,
  n = 2,
  free_val = NULL,
  values = NULL,
  lbound_val = NULL,
  ubound_val = NULL,
  vec = TRUE,
  name = "beta"
)
#> $free
#>      [,1] [,2]
#> [1,] TRUE TRUE
#> [2,] TRUE TRUE
#> 
#> $values
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
#> 
#> $labels
#>      [,1]       [,2]      
#> [1,] "beta_1_1" "beta_1_2"
#> [2,] "beta_2_1" "beta_2_2"
#> 
#> $lbound
#>      [,1] [,2]
#> [1,]   NA   NA
#> [2,]   NA   NA
#> 
#> $ubound
#>      [,1] [,2]
#> [1,]   NA   NA
#> [2,]   NA   NA
#> 
#> $vec
#>      [,1]        [,2]       
#> [1,] "beta[1,1]" "beta[1,2]"
#> [2,] "beta[2,1]" "beta[2,2]"
#> 
```
