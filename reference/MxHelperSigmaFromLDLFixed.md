# Fixed Covariance Matrix from LDL Parts

Builds a covariance matrix with no free elements from the strictly lower
triangular part of \\(\boldsymbol{L}\\) and the unconstrained diagonal
of \\(\boldsymbol{D}\\), as
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md)
does. The matrices are named `<name>_l` and `<name>_d`; the model must
hold the identity matrix `iden_name`. The arguments are checked first;
the internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSigmaFromLDLFixed(p, d_values, l_values, row, name, iden_name)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- d_values:

  Numeric vector. Unconstrained diagonal of \\(\boldsymbol{D}\\) (the
  element `uc_d` of `LDL`).

- l_values:

  Numeric matrix. Strictly lower triangular part of \\(\boldsymbol{L}\\)
  (the element `s_l` of `LDL`).

- row:

  Character vector or `NULL`. Names of the variables (rows and columns).

- name:

  Character string. Name of the matrix or algebra.

- iden_name:

  Character string or `NULL`. Name of the identity matrix, which the
  model must hold. If `NULL`, `<name>_iden`.

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
[`MxHelperSigmaFromLDLLogAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLLogAlgebra.md),
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md),
[`MxHelperSigmaFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLSoftplusAlgebra.md),
[`MxHelperSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSoftplus.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
ldl <- MxHelperLDL(
  x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
)
MxHelperSigmaFromLDLFixed(
  p = 2,
  d_values = ldl$uc_d,
  l_values = ldl$s_l,
  row = c("y1", "y2"),
  name = "sigma",
  iden_name = NULL
)
#> $sigma_l
#> SdiagMatrix 'sigma_l' 
#> 
#> $labels: No labels assigned.
#> 
#> $values
#>      y1 y2
#> y1 0.00  0
#> y2 0.25  0
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
#> $labels: No labels assigned.
#> 
#> $values
#>      sigma_d
#> y1 1.8545865
#> y2 0.3356686
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
```
