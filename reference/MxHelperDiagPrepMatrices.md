# Arguments of a Diag OpenMx Matrix

Builds the free elements, values, labels, and bounds of the diagonal of
a `p` by `p` matrix for
[`OpenMx::mxMatrix()`](https://rdrr.io/pkg/OpenMx/man/mxMatrix.html).
Labels and bounds of fixed elements are set to `NA`. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperDiagPrepMatrices(
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

Other Diagonal Matrix Functions:
[`MxHelperDiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagBound.md),
[`MxHelperDiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagFree.md),
[`MxHelperDiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagLabels.md),
[`MxHelperDiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagMxMatrix.md),
[`MxHelperDiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDiagPrepMatrices(
  p = 2,
  free_val = NULL,
  values = NULL,
  lbound_val = NULL,
  ubound_val = NULL,
  vec = TRUE,
  name = "beta"
)
#> $free
#> [1] TRUE TRUE
#> 
#> $values
#> [1] 0 0
#> 
#> $labels
#> [1] "beta_1_1" "beta_2_2"
#> 
#> $lbound
#> [1] NA NA
#> 
#> $ubound
#> [1] NA NA
#> 
#> $vec
#> [1] "beta[1,1]" "beta[2,2]"
#> 
```
