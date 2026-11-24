# OpenMx Algebra of a Covariance Matrix from LDL Parts

The covariance matrix is \\(\boldsymbol{\Sigma} = \boldsymbol{L}
\boldsymbol{D} \boldsymbol{L}^{\prime}\\), with \\(\boldsymbol{L}\\)
unit lower triangular and \\(\boldsymbol{D}\\) diagonal; the diagonal of
\\(\boldsymbol{D}\\) is the softplus of an unconstrained vector, so
\\(\boldsymbol{\Sigma}\\) stays positive definite. This function builds
that algebra, with a softplus written in OpenMx algebra and
\\(10^{-8}\\) added to the diagonal of \\(\boldsymbol{D}\\). The
arguments are checked first; the internal version, without checks, is
the one other projects copy.

## Usage

``` r
MxHelperSigmaFromLDLSoftplusAlgebra(sdiag, column, iden, name)
```

## Arguments

- sdiag:

  Character string. Name of the strictly lower triangular matrix
  \\(\boldsymbol{L}\\) minus the identity.

- column:

  Character string. Name of the column vector of unconstrained diagonal
  elements of \\(\boldsymbol{D}\\).

- iden:

  Character string. Name of the identity matrix.

- name:

  Character string. Name of the matrix or algebra.

## Value

Returns an OpenMx algebra (`MxAlgebra`) named `name`.

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
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md),
[`MxHelperSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSoftplus.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSigmaFromLDLSoftplusAlgebra(
  sdiag = "sigma_l",
  column = "sigma_d",
  iden = "sigma_iden",
  name = "sigma"
)
#> mxAlgebra 'sigma' 
#> $formula:  (sigma_l + sigma_iden) %*% vec2diag(((sigma_d + abs(sigma_d))/2 + mxRobustLog(1 + exp(-abs(sigma_d)))) + 1e-08) %*% t(sigma_l + sigma_iden) 
#> $result: (not yet computed) <0 x 0 matrix>
#> dimnames: NULL
```
