# A Fixed Full OpenMx Matrix

Builds an `m` by `n` OpenMx matrix of type `"Full"` with no free
elements. The arguments are checked first; the internal version, without
checks, is the one other projects copy.

## Usage

``` r
MxHelperFullFixed(m, n, values, row, col, name)
```

## Arguments

- m:

  Positive integer. Number of rows.

- n:

  Positive integer. Number of columns.

- values:

  Numeric matrix or `NULL`. Fixed values of the matrix. If `NULL`,
  zeros.

- row:

  Character vector or `NULL`. Row names of the matrix. If `NULL`, `i_1`,
  ..., `i_m`.

- col:

  Character vector or `NULL`. Column names of the matrix. If `NULL`,
  `j_1`, ..., `j_n`.

- name:

  Character string. Name of the matrix or algebra.

## Value

Returns a named list with one OpenMx matrix, `name`.

## See also

Other Full Matrix Functions:
[`MxHelperFullBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullBound.md),
[`MxHelperFullFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFree.md),
[`MxHelperFullLabels()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullLabels.md),
[`MxHelperFullMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullMxMatrix.md),
[`MxHelperFullPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullPrepMatrices.md),
[`MxHelperFullValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperFullFixed(
  m = 2,
  n = 2,
  values = diag(x = 2),
  row = NULL,
  col = NULL,
  name = "iden"
)
#> $iden
#> FullMatrix 'iden' 
#> 
#> $labels: No labels assigned.
#> 
#> $values
#>     j_1 j_2
#> i_1   1   0
#> i_2   0   1
#> 
#> $free: No free parameters.
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
```
