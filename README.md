mxHelper
================
Ivan Jacob Agaloos Pesigan

<!-- README.md is generated from .setup/readme/README.Rmd. Please edit that file -->

<!-- badges: start -->
[![Make Project (make all)](https://github.com/ijapesigan/mxHelper/actions/workflows/make-all.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/make-all.yml)
[![Make Project](https://github.com/ijapesigan/mxHelper/actions/workflows/make.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/make.yml)
[![R-CMD-check-full](https://github.com/ijapesigan/mxHelper/actions/workflows/check-full.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/check-full.yml)
[![R-CMD-check-oldrel](https://github.com/ijapesigan/mxHelper/actions/workflows/check-oldrel.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/check-oldrel.yml)
[![R-CMD-check-standard](https://github.com/ijapesigan/mxHelper/actions/workflows/check-standard.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/check-standard.yml)
[![Compile LaTeX](https://github.com/ijapesigan/mxHelper/actions/workflows/latex.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/latex.yml)
[![Lint R Package](https://github.com/ijapesigan/mxHelper/actions/workflows/lint.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/lint.yml)
[![Non-ASCII Check](https://github.com/ijapesigan/mxHelper/actions/workflows/non-ascii-check.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/non-ascii-check.yml)
[![Package Website (GitHub Pages)](https://github.com/ijapesigan/mxHelper/actions/workflows/pkgdown-gh-pages.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/pkgdown-gh-pages.yml)
[![rhub 1 (essential)](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-1-essential.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-1-essential.yml)
[![rhub 2 (memory)](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-2-memory.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-2-memory.yml)
[![rhub 3 (numerics), review only](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-3-numerics.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-3-numerics.yml)
[![rhub 4 (compilers), review only](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-4-compilers.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/rhub-4-compilers.yml)
[![Shell Check](https://github.com/ijapesigan/mxHelper/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/shellcheck.yml)
[![Source Code](https://github.com/ijapesigan/mxHelper/actions/workflows/source.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/source.yml)
[![R Package Test Coverage](https://github.com/ijapesigan/mxHelper/actions/workflows/test-coverage.yml/badge.svg)](https://github.com/ijapesigan/mxHelper/actions/workflows/test-coverage.yml)
<!-- badges: end -->

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

``` r
if (!require("pak")) install.packages("pak")
pak::pkg_install("ijapesigan/mxHelper")
```

## More Information

See [GitHub Pages](https://ijapesigan.github.io/mxHelper) for package
documentation.

## References

<div id="refs" class="references csl-bib-body hanging-indent"
data-entry-spacing="0" data-line-spacing="2">

<div id="ref-Neale-Hunter-Pritikin-etal-2016" class="csl-entry">

Neale, M. C., Hunter, M. D., Pritikin, J. N., Zahery, M., Brick, T. R.,
Kirkpatrick, R. M., Estabrook, R., Bates, T. C., Maes, H. H., & Boker,
S. M. (2016). OpenMx 2.0: Extended structural equation and statistical
modeling. *Psychometrika*, *81*(2), 535–549.
<https://doi.org/10.1007/s11336-014-9435-8>

</div>

<div id="ref-RCoreTeam-2026" class="csl-entry">

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>

</div>

</div>
