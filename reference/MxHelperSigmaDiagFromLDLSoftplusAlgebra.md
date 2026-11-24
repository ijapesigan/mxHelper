# OpenMx Algebra of a Diagonal Covariance Matrix

Builds the OpenMx algebra of a diagonal covariance matrix whose diagonal
is the softplus of the column vector `column`, plus \\(10^{-8}\\), so
that it stays positive. The arguments are checked first; the internal
version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSigmaDiagFromLDLSoftplusAlgebra(column, name)
```

## Arguments

- column:

  Character string. Name of the column vector of unconstrained diagonal
  elements of \\(\boldsymbol{D}\\).

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
MxHelperSigmaDiagFromLDLSoftplusAlgebra(
  column = "sigma_d",
  name = "sigma"
)
#> mxAlgebra 'sigma' 
#> $formula:  vec2diag(((sigma_d + abs(sigma_d))/2) + mxRobustLog(1 + exp(-abs(sigma_d))) + 1e-08) 
#> $result: (not yet computed) <0 x 0 matrix>
#> dimnames: NULL
```
