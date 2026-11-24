# mxHelper

Ivan Jacob Agaloos Pesigan

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

## More Information

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
