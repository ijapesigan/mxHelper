# LDL Decomposition of a Covariance Matrix

Decomposes a symmetric positive definite matrix as
\\(\boldsymbol{\Sigma} = \boldsymbol{L} \boldsymbol{D}
\boldsymbol{L}^{\prime}\\), with \\(\boldsymbol{L}\\) unit lower
triangular and \\(\boldsymbol{D}\\) diagonal, and returns the parts in
the form that
[`MxHelperSigmaFromLDLMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLMxMatrix.md)
takes as starting values. A zero on the diagonal of `x` is replaced by
`epsilon` first. The arguments are checked first; the internal version,
without checks, is the one other projects copy.

## Usage

``` r
MxHelperLDL(x, epsilon = 1e-10)
```

## Arguments

- x:

  Numeric matrix. Symmetric positive definite matrix
  (\\(\boldsymbol{\Sigma}\\)).

- epsilon:

  Positive number. Value that replaces a zero on the diagonal of `x`.

## Value

Returns a list with the elements

- l:

  Unit lower triangular matrix \\(\boldsymbol{L}\\).

- s_l:

  Strictly lower triangular part of \\(\boldsymbol{L}\\).

- d:

  Diagonal of \\(\boldsymbol{D}\\).

- uc_d:

  Inverse softplus of `d`.

- x:

  The input, after the diagonal replacement.

- epsilon:

  The value of `epsilon`.

## See also

Other Covariance Matrix Functions:
[`MxHelperInvLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvLDL.md),
[`MxHelperInvSoftplus()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvSoftplus.md),
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
MxHelperLDL(
  x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
)
#> $l
#>      [,1] [,2]
#> [1,] 1.00    0
#> [2,] 0.25    1
#> 
#> $s_l
#>      [,1] [,2]
#> [1,] 0.00    0
#> [2,] 0.25    0
#> 
#> $d
#> [1] 2.000 0.875
#> 
#> $uc_d
#> [1] 1.8545865 0.3356686
#> 
#> $x
#>      [,1] [,2]
#> [1,]  2.0  0.5
#> [2,]  0.5  1.0
#> 
#> $epsilon
#> [1] 1e-10
#> 
```
