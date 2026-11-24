# Labels of a Full Matrix

Builds the parameter labels of an `m` by `n` matrix from the name of the
matrix and the row and column indices. The arguments are checked first;
the internal version, without checks, is the one other projects copy.

## Usage

``` r
MxHelperFullLabels(m, n, name, sep)
```

## Arguments

- m:

  Positive integer. Number of rows.

- n:

  Positive integer. Number of columns.

- name:

  Character string. Name of the matrix or algebra.

- sep:

  Character string. Separator of the row and column indices in the
  labels: `"underscore"` (`name_i_j`) or `"bracket"` (`name[i,j]`).

## Value

Returns a character matrix.

## See also

Other Full Matrix Functions:
[`MxHelperFullBound()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullBound.md),
[`MxHelperFullFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFixed.md),
[`MxHelperFullFree()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullFree.md),
[`MxHelperFullMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullMxMatrix.md),
[`MxHelperFullPrepMatrices()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullPrepMatrices.md),
[`MxHelperFullValues()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperFullValues.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
MxHelperFullLabels(
  m = 2,
  n = 2,
  name = "beta",
  sep = "underscore"
)
#>      [,1]       [,2]      
#> [1,] "beta_1_1" "beta_1_2"
#> [2,] "beta_2_1" "beta_2_2"
```
