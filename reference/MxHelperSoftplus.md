# Softplus

Computes the softplus \\(\log \left( 1 + \exp \left( x \right)
\right)\\) elementwise, in a form that does not overflow: \\(\left( x +
\left\| x \right\| \right) / 2 + \log \left( 1 + \exp \left( - \left\| x
\right\| \right) \right)\\). The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSoftplus(x)
```

## Arguments

- x:

  Numeric vector or matrix.

## Value

Returns a numeric vector or matrix of the shape of `x`, with positive
elements.

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
[`MxHelperSigmaFromLDLSoftplusAlgebra()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFromLDLSoftplusAlgebra.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSoftplus(
  x = c(-1, 0, 1)
)
#> [1] 0.3132617 0.6931472 1.3132617
```
