# OpenMx Matrices of a Covariance Matrix from LDL Parts

The covariance matrix is \\(\boldsymbol{\Sigma} = \boldsymbol{L}
\boldsymbol{D} \boldsymbol{L}^{\prime}\\), with \\(\boldsymbol{L}\\)
unit lower triangular and \\(\boldsymbol{D}\\) diagonal; the diagonal of
\\(\boldsymbol{D}\\) is the softplus of an unconstrained vector, so
\\(\boldsymbol{\Sigma}\\) stays positive definite. This function builds
the OpenMx matrices and algebras: \\(\boldsymbol{L}\\) below the
diagonal (`sdiag_name`), the unconstrained diagonal of
\\(\boldsymbol{D}\\) (`column_name`), the identity (when
`iden_name = NULL`), \\(\boldsymbol{\Sigma}\\) (`name`), its
half-vectorization (`<name>_vech`), and a column vector of the free
elements (`<name>_vec`). The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSigmaFromLDLMxMatrix(
  p,
  name,
  column_name,
  sdiag_name,
  iden_name,
  d_free,
  d_values,
  d_lbound,
  d_ubound,
  d_rows,
  d_cols,
  d_equal,
  l_free,
  l_values,
  l_lbound,
  l_ubound,
  l_rows,
  l_cols
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

- sdiag_name:

  Character string. Name of the strictly lower triangular matrix of
  \\(\boldsymbol{L}\\).

- iden_name:

  Character string or `NULL`. Name of the identity matrix. If `NULL`,
  the function adds one named `<name>_iden`; otherwise the model must
  hold it.

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

- l_free:

  Logical vector or matrix, or `NULL`. Which elements of
  \\(\boldsymbol{L}\\) below the diagonal are free. `NULL` means all.

- l_values:

  Numeric vector or matrix, or `NULL`. Starting values of
  \\(\boldsymbol{L}\\) below the diagonal. `NULL` means zeros.

- l_lbound:

  Numeric vector or matrix, or `NULL`. Lower bounds of
  \\(\boldsymbol{L}\\) below the diagonal.

- l_ubound:

  Numeric vector or matrix, or `NULL`. Upper bounds of
  \\(\boldsymbol{L}\\) below the diagonal.

- l_rows:

  Character vector or `NULL`. Row names of \\(\boldsymbol{L}\\).

- l_cols:

  Character vector or `NULL`. Column names of \\(\boldsymbol{L}\\).

## Value

Returns a named list of OpenMx matrices and algebras.

## See also

Other Covariance Matrix Functions:
[`MxHelperInvLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvLDL.md),
[`MxHelperInvSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvSoftplus.md),
[`MxHelperLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperLDL.md),
[`MxHelperSigmaDiagFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaDiagFromLDLMxMatrix.md),
[`MxHelperSigmaDiagFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaDiagFromLDLSoftplusAlgebra.md),
[`MxHelperSigmaFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFixed.md),
[`MxHelperSigmaFromLDLFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLFixed.md),
[`MxHelperSigmaFromLDLLogAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLLogAlgebra.md),
[`MxHelperSigmaFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLSoftplusAlgebra.md),
[`MxHelperSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSoftplus.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
ldl <- MxHelperLDL(
  x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
)
MxHelperSigmaFromLDLMxMatrix(
  p = 2,
  name = "sigma",
  column_name = "sigma_d",
  sdiag_name = "sigma_l",
  iden_name = NULL,
  d_free = TRUE,
  d_values = ldl$uc_d,
  d_lbound = NA,
  d_ubound = NA,
  d_rows = NULL,
  d_cols = NULL,
  d_equal = FALSE,
  l_free = TRUE,
  l_values = ldl$s_l,
  l_lbound = NA,
  l_ubound = NA,
  l_rows = NULL,
  l_cols = NULL
)
#> $sigma_l
#> SdiagMatrix 'sigma_l' 
#> 
#> $labels
#>     j_1           j_2
#> i_1 NA            NA 
#> i_2 "sigma_l_2_1" NA 
#> 
#> $values
#>      j_1 j_2
#> i_1 0.00   0
#> i_2 0.25   0
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
#> $sigma_l_vec
#> FullMatrix 'sigma_l_vec' 
#> 
#> $labels
#>              sigma_l_vec   
#> sigma_l[2,1] "sigma_l[2,1]"
#> 
#> $values
#>              sigma_l_vec
#> sigma_l[2,1]           0
#> 
#> $free: No free parameters.
#> 
#> $lbound: No lower bounds assigned.
#> 
#> $ubound: No upper bounds assigned.
#> 
#> 
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
#> i_1 1.8545865
#> i_2 0.3356686
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
#> $sigma_iden
#> IdenMatrix 'sigma_iden' 
#> 
#> $labels: No labels assigned.
#> 
#> $values
#>      [,1] [,2]
#> [1,]    1    0
#> [2,]    0    1
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
#> $formula:  (sigma_l + sigma_iden) %*% vec2diag(((sigma_d + abs(sigma_d))/2 + mxRobustLog(1 + exp(-abs(sigma_d)))) + 1e-08) %*% t(sigma_l + sigma_iden) 
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
#> sigma[2,1] "sigma[2,1]"
#> sigma[2,2] "sigma[2,2]"
#> 
#> $values
#>            sigma_vec
#> sigma[1,1]         0
#> sigma[2,1]         0
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
