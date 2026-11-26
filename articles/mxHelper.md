# mxHelper: Helper Functions for 'OpenMx'

## Description

Helper functions for `OpenMx` models in R (Neale et al., 2016; R Core
Team, 2026): matrices with labels, bounds, and vectors of free
parameters; covariance matrices from the LDL decomposition with a
softplus diagonal; starting values for vector autoregressive models; and
fitting until the Hessian is positive definite, with diagnostics and
bound handling. Each exported function has an internal version without
input checks that other projects can copy.

## Installation

You can install the development version of `mxHelper` from
[GitHub](https://github.com/ijapesigan/mxHelper) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"ijapesigan/mxHelper"``)`

## Example

\
[`library`](https://rdrr.io/r/base/library.html)`(``package ``=`` ``"mxHelper"``)`\
[`set.seed`](https://rdrr.io/r/base/Random.html)`(``seed ``=`` ``42``)`\
`x`` ``<-`` `[`data.frame`](https://rdrr.io/r/base/data.frame.html)`(`\
`  y1 ``=`` ``stats``::`[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``n ``=`` ``100``)``,`\
`  y2 ``=`` ``stats``::`[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``n ``=`` ``100``)`\
`)`\
`fit`` ``<-`` `[`MxHelperQuiet`](https://ijapesigan.github.io/mxHelper/reference/MxHelperQuiet.md)`(`\
`  expr ``=`` `[`MxHelperMuSigma`](https://ijapesigan.github.io/mxHelper/reference/MxHelperMuSigma.md)`(``x ``=`` ``x``, extraTries ``=`` ``2``)`\
`)`\
[`MxHelperIsGoodFit`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md)`(``x ``=`` ``fit``)`\
`#> [1] TRUE`\
`#> attr(,"criterion")`\
`#> [1] "newton"`\
[`MxHelperHasPdHessian`](https://ijapesigan.github.io/mxHelper/reference/MxHelperHasPdHessian.md)`(``x ``=`` ``fit``)`\
`#> [1] TRUE`\
`OpenMx``::`[`mxEval`](https://rdrr.io/pkg/OpenMx/man/mxEval.html)`(``expression ``=`` ``sigma``, model ``=`` ``fit``)`\
`#>            [,1]       [,2]`\
`#> [1,] 1.07362677 0.02915809`\
`#> [2,] 0.02915809 0.80939139`

## Documentation

See [GitHub Pages](https://ijapesigan.github.io/mxHelper) for package
documentation.

## References

Neale, M. C., Hunter, M. D., Pritikin, J. N., Zahery, M., Brick, T. R.,
Kirkpatrick, R. M., Estabrook, R., Bates, T. C., Maes, H. H., & Boker,
S. M. (2016). OpenMx 2.0: Extended structural equation and statistical
modeling. *Psychometrika*, *81*(2), 535–549.
<https://doi.org/10.1007/s11336-014-9435-8>

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>
