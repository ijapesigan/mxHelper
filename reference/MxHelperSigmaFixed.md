# Fixed Covariance Matrix

Builds a covariance matrix with no free elements, from `values` or, when
`values = NULL`, from `type`, as
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md)
does. The model must hold the identity matrix `iden_name`. The arguments
are checked first; the internal version, without checks, is the one
other projects copy.

## Usage

``` r
MxHelperSigmaFixed(p, values, row, name, iden_name = NULL, type)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- values:

  Numeric matrix or `NULL`. Covariance matrix. If `NULL`, set by `type`.

- row:

  Character vector or `NULL`. Names of the variables (rows and columns).

- name:

  Character string. Name of the matrix or algebra.

- iden_name:

  Character string or `NULL`. Name of the identity matrix, which the
  model must hold. If `NULL`, `<name>_iden`.

- type:

  Character string or `NULL`. Covariance when `values = NULL`: `"zero"`
  (1e-10 times the identity), `"identity"`, or `"diffused"` (1e10 times
  the identity). The algebra adds 1e-8 to each element of the diagonal
  of the LDL decomposition, so `"zero"` evaluates to (1e-10 + 1e-8)
  times the identity.

## Value

Returns a named list of OpenMx matrices and algebras.

## See also

Other Covariance Matrix Functions:
[`MxHelperInvLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvLDL.md),
[`MxHelperInvSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvSoftplus.md),
[`MxHelperLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperLDL.md),
[`MxHelperSigmaDiagFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaDiagFromLDLMxMatrix.md),
[`MxHelperSigmaDiagFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaDiagFromLDLSoftplusAlgebra.md),
[`MxHelperSigmaFromLDLFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLFixed.md),
[`MxHelperSigmaFromLDLLogAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLLogAlgebra.md),
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md),
[`MxHelperSigmaFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLSoftplusAlgebra.md),
[`MxHelperSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSoftplus.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSigmaFixed(
  p = 2,
  values = NULL,
  row = c("y1", "y2"),
  name = "sigma",
  iden_name = NULL,
  type = "identity"
)
#> $sigma_l
#> SdiagMatrix 'sigma_l' 
#> 
#> $labels: No labels assigned.
#> 
#> $values
#>    y1 y2
#> y1  0  0
#> y2  0  0
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
#> y1 0.5413249
#> y2 0.5413249
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
