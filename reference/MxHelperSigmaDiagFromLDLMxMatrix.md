# OpenMx Matrices of a Diagonal Covariance Matrix

Builds a diagonal covariance matrix whose diagonal is the softplus of an
unconstrained column vector: the column vector (`column_name`), the
algebra (`name`), its half-vectorization (`<name>_vech`), and a column
vector of the free elements (`<name>_vec`). With `d_equal = TRUE`, the
free diagonal elements are equal. The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSigmaDiagFromLDLMxMatrix(
  p,
  name,
  column_name,
  d_free,
  d_values,
  d_lbound,
  d_ubound,
  d_rows,
  d_cols,
  d_equal
)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- name:

  Character string. Name of the matrix or algebra.

- column_name:

  Character string. Name of the column vector of unconstrained diagonal
  elements of \\(\boldsymbol{D}\\).

- d_free:

  Logical vector or `NULL`. Which diagonal elements are free. `NULL`
  means all.

- d_values:

  Numeric vector, matrix, or `NULL`. Starting values of the
  unconstrained diagonal elements: a vector of length `p`, a `p` by 1
  matrix, or a `p` by `p` matrix whose diagonal is used. If `NULL`, the
  inverse softplus of 1.

- d_lbound:

  Numeric vector or `NULL`. Lower bounds of the unconstrained diagonal
  elements.

- d_ubound:

  Numeric vector or `NULL`. Upper bounds of the unconstrained diagonal
  elements.

- d_rows:

  Character vector or `NULL`. Row names of the column vector.

- d_cols:

  Character vector or `NULL`. Column name of the column vector.

- d_equal:

  Logical. If `TRUE`, the free diagonal elements share one label
  (`<column_name>_eq`), so they are equal.

## Value

Returns a named list of OpenMx matrices and algebras.

## See also

Other Covariance Matrix Functions:
[`MxHelperInvLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvLDL.md),
[`MxHelperInvSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvSoftplus.md),
[`MxHelperLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperLDL.md),
[`MxHelperSigmaDiagFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaDiagFromLDLSoftplusAlgebra.md),
[`MxHelperSigmaFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFixed.md),
[`MxHelperSigmaFromLDLFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLFixed.md),
[`MxHelperSigmaFromLDLLogAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLLogAlgebra.md),
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md),
[`MxHelperSigmaFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLSoftplusAlgebra.md),
[`MxHelperSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSoftplus.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSigmaDiagFromLDLMxMatrix(
  p = 2,
  name = "sigma",
  column_name = "sigma_d",
  d_free = TRUE,
  d_values = NULL,
  d_lbound = NA,
  d_ubound = NA,
  d_rows = NULL,
  d_cols = NULL,
  d_equal = FALSE
)
#> $sigma_d
#> FullMatrix 'sigma_d' 
#> 
#> $labels
#>     j_1          
#> i_1 "sigma_d_1_1"
#> i_2 "sigma_d_2_1"
#> 
#> $values
#>           j_1
#> i_1 0.5413249
#> i_2 0.5413249
#> 
#> $free
#>      j_1
#> i_1 TRUE
#> i_2 TRUE
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
#> $sigma_d_vec
#> FullMatrix 'sigma_d_vec' 
#> 
#> $labels
#>              sigma_d_vec   
#> sigma_d[1,1] "sigma_d[1,1]"
#> sigma_d[2,1] "sigma_d[2,1]"
#> 
#> $values
#>              sigma_d_vec
#> sigma_d[1,1]           0
#> sigma_d[2,1]           0
#> 
#> $free: No free parameters.
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
#> $sigma
#> mxAlgebra 'sigma' 
#> $formula:  vec2diag(((sigma_d + abs(sigma_d))/2) + mxRobustLog(1 + exp(-abs(sigma_d))) + 1e-08) 
#> $result: (not yet computed) <0 x 0 matrix>
#> dimnames: NULL
#> 
#> $sigma_vech
#> mxAlgebra 'sigma_vech' 
#> $formula:  vech(sigma) 
#> $result: (not yet computed) <0 x 0 matrix>
#> dimnames: NULL
#> 
#> $sigma_vec
#> FullMatrix 'sigma_vec' 
#> 
#> $labels
#>            sigma_vec   
#> sigma[1,1] "sigma[1,1]"
#> sigma[2,2] "sigma[2,2]"
#> 
#> $values
#>            sigma_vec
#> sigma[1,1]         0
#> sigma[2,2]         0
#> 
#> $free: No free parameters.
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
```
