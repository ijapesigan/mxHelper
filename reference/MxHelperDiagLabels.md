# Labels of a Diag Matrix

Builds the parameter labels of the diagonal of a `p` by `p` matrix from
the name of the matrix and the row and column indices. Only the diagonal
is kept. The arguments are checked first; the internal version, without
checks, is the one other projects copy.

## Usage

``` r
MxHelperDiagLabels(p, name, sep)
```

## Arguments

- p:

  Positive integer. Number of rows and columns of the square matrix.

- name:

  Character string. Name of the matrix or algebra.

- sep:

  Character string. Separator of the row and column indices in the
  labels: `"underscore"` (`name_i_j`) or `"bracket"` (`name[i,j]`).

## Value

Returns a character vector of length `p`.

## See also

Other Diagonal Matrix Functions:
[`MxHelperDiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagBound.md),
[`MxHelperDiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagFree.md),
[`MxHelperDiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagMxMatrix.md),
[`MxHelperDiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagPrepMatrices.md),
[`MxHelperDiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperDiagLabels(
  p = 2,
  name = "beta",
  sep = "underscore"
)
#> [1] "beta_1_1" "beta_2_2"
```
