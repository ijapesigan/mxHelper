# Labels of a Sym Matrix

Builds the parameter labels of a `p` by `p` symmetric matrix from the
name of the matrix and the row and column indices. The lower triangle is
copied to the upper triangle. The arguments are checked first; the
internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperSymLabels(p, name, sep)
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

Other Symmetric Matrix Functions:
[`MxHelperSymBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymBound.md),
[`MxHelperSymFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymFree.md),
[`MxHelperSymMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymMxMatrix.md),
[`MxHelperSymPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymPrepMatrices.md),
[`MxHelperSymValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSymValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperSymLabels(
  p = 2,
  name = "beta",
  sep = "underscore"
)
#>      [,1]       [,2]      
#> [1,] "beta_1_1" "beta_2_1"
#> [2,] "beta_2_1" "beta_2_2"
```
