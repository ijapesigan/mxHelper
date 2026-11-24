# Labels of a Sdiag Matrix

Builds the parameter labels of a `p` by `p` strictly lower triangular
matrix from the name of the matrix and the row and column indices. The
diagonal and the upper triangle have no labels. The arguments are
checked first; the internal version, without checks, is the one other
projects copy.

## Usage

``` r
MxHelperSdiagLabels(p, name, sep)
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

Returns a character matrix.

## See also

Other Strictly Lower Triangular Matrix Functions:
[`MxHelperSdiagBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagBound.md),
[`MxHelperSdiagFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagFree.md),
[`MxHelperSdiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagMxMatrix.md),
[`MxHelperSdiagPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagPrepMatrices.md),
[`MxHelperSdiagValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSdiagValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSdiagLabels(
  p = 2,
  name = "beta",
  sep = "underscore"
)
#>      [,1]       [,2]
#> [1,] NA         NA  
#> [2,] "beta_2_1" NA  
```
