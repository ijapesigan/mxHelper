# Covariance Matrix from its LDL Parts

Rebuilds \\(\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
\boldsymbol{L}^{\prime}\\) from the strictly lower triangular part of
\\(\boldsymbol{L}\\) and the unconstrained diagonal of
\\(\boldsymbol{D}\\): the inverse of
[`MxHelperLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperLDL.md).
Elements of `s_l` on or above the diagonal are ignored. The result is
symmetrized. The arguments are checked first; the internal version,
without checks, is the one other projects copy.

## Usage

``` r
MxHelperInvLDL(s_l, uc_d)
```

## Arguments

- s_l:

  Numeric matrix. Strictly lower triangular part of \\(\boldsymbol{L}\\)
  (the element `s_l` of `LDL`).

- uc_d:

  Numeric vector. Unconstrained diagonal of \\(\boldsymbol{D}\\), the
  inverse softplus of its elements (the element `uc_d` of `LDL`).

## Value

Returns a symmetric numeric matrix.

## See also

Other Covariance Matrix Functions:
[`MxHelperInvSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvSoftplus.md),
[`MxHelperLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperLDL.md),
[`MxHelperSigmaDiagFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaDiagFromLDLMxMatrix.md),
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
ldl <- MxHelperLDL(
  x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
)
MxHelperInvLDL(
  s_l = ldl$s_l,
  uc_d = ldl$uc_d
)
#>      [,1] [,2]
#> [1,]  2.0  0.5
#> [2,]  0.5  1.0
```
