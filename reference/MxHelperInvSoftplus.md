# Inverse Softplus

Computes the inverse of the softplus, \\(\log \left( \exp \left( x
\right) - 1 \right)\\), elementwise; for \\(x \> 20\\), as \\(x + \log
\left( 1 - \exp \left( - x \right) \right)\\) to avoid overflow. Stops
with an error when an element is not positive. The arguments are checked
first; the internal version, without checks, is the one other projects
copy.

## Usage

``` r
MxHelperInvSoftplus(x)
```

## Arguments

- x:

  Numeric vector or matrix with positive elements.

## Value

Returns a numeric vector or matrix of the shape of `x`.

## See also

Other Covariance Matrix Functions:
[`MxHelperInvLDL()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperInvLDL.md),
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
MxHelperInvSoftplus(
  x = c(0.5, 1, 2)
)
#> [1] -0.4327521  0.5413249  1.8545865
```
