# A Sdiag OpenMx Matrix

Builds a `p` by `p` strictly lower triangular matrix as an OpenMx matrix
of type `"Sdiag"`. With `vec = TRUE`, it also builds a column vector
(`<name>_vec`) of the free elements, labelled with their bracket labels,
so that they can be extracted as a vector. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperSdiagMxMatrix(
  p,
  free_val,
  values,
  lbound_val,
  ubound_val,
  vec,
  row,
  col,
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

- row:

  Character vector or `NULL`. Row names of the matrix. If `NULL`, `i_1`,
  ..., `i_m`.

- col:

  Character vector or `NULL`. Column names of the matrix. If `NULL`,
  `j_1`, ..., `j_n`.

- name:

  Character string. Name of the matrix or algebra.

## Value

Returns a named list of OpenMx matrices: the matrix `name`, and with
`vec = TRUE` and at least one free element, the column vector
`<name>_vec`.

## See also

Other Strictly Lower Triangular Matrix Functions:
[`MxHelperSdiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagBound.md),
[`MxHelperSdiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagFree.md),
[`MxHelperSdiagLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagLabels.md),
[`MxHelperSdiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagPrepMatrices.md),
[`MxHelperSdiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSdiagMxMatrix(
  p = 2,
  free_val = NULL,
  values = NULL,
  lbound_val = NULL,
  ubound_val = NULL,
  vec = TRUE,
  row = NULL,
  col = NULL,
  name = "beta"
)
#> $beta
#> SdiagMatrix 'beta' 
#> 
#> $labels
#>     j_1        j_2
#> i_1 NA         NA 
#> i_2 "beta_2_1" NA 
#> 
#> $values
#>     j_1 j_2
#> i_1   0   0
#> i_2   0   0
#> 
#> $free
#>       j_1   j_2
#> i_1 FALSE FALSE
#> i_2  TRUE FALSE
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
#> $beta_vec
#> FullMatrix 'beta_vec' 
#> 
#> $labels
#>           beta_vec   
#> beta[2,1] "beta[2,1]"
#> 
#> $values
#>           beta_vec
#> beta[2,1]        0
#> 
#> $free: No free parameters.
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
```
