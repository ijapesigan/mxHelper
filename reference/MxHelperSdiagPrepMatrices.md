# Arguments of a Sdiag OpenMx Matrix

Builds the free elements, values, labels, and bounds of a `p` by `p`
strictly lower triangular matrix for
[`OpenMx::mxMatrix()`](https://rdrr.io/pkg/OpenMx/man/mxMatrix.html).
Labels and bounds of fixed elements are set to `NA`. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperSdiagPrepMatrices(
  p,
  free_val,
  values,
  lbound_val,
  ubound_val,
  vec,
  name
)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

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

Other Strictly Lower Triangular Matrix Functions:
[`MxHelperSdiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagBound.md),
[`MxHelperSdiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagFree.md),
[`MxHelperSdiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagLabels.md),
[`MxHelperSdiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagMxMatrix.md),
[`MxHelperSdiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSdiagPrepMatrices(
  p = 2,
  free_val = NULL,
  values = NULL,
  lbound_val = NULL,
  ubound_val = NULL,
  vec = TRUE,
  name = "beta"
)
#> $free
#>       [,1]  [,2]
#> [1,] FALSE FALSE
#> [2,]  TRUE FALSE
#> 
#> $values
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
#> 
#> $labels
#>      [,1]       [,2]
#> [1,] NA         NA  
#> [2,] "beta_2_1" NA  
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
#> [1,] NA          NA  
#> [2,] "beta[2,1]" NA  
#> 
```
