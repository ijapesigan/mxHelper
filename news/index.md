# Changelog

## mxHelper 0.0.4

### New features

- [`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md)
  and `.MxHelperIsGoodFit()` gain `nd_tol` (default `1e-4`): a fit that
  fails the gradient test (`grad_tol`) is still good when its Newton
  decrement `g' H^{-1} g` is below `nd_tol` and its Hessian is positive
  definite. The test does not depend on the scale of the parameters, so
  a converged fit with a near-zero variance (a gradient of about 0.05 on
  its coefficients) is no longer sent to a rescue. `nd_tol = NULL` or
  `0` gives the old behaviour.
- `TRUE` from
  [`MxHelperIsGoodFit()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperIsGoodFit.md)
  has the attribute `criterion`: `"gradient"` or `"newton"`.
  [`isTRUE()`](https://rdrr.io/r/base/Logic.html) and `if ()` ignore it.
- `nd_tol` is passed on by
  [`MxHelperNeedsRescue()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperNeedsRescue.md),
  [`MxHelperRun()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperRun.md),
  [`MxHelperEnsureGoodHessian()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperEnsureGoodHessian.md),
  [`MxHelperReadRunSave()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperReadRunSave.md),
  and their internal versions.

## mxHelper 0.0.3

### Patch

- [`MxHelperSigmaFixed()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperSigmaFixed.md)
  and `.MxHelperSigmaFixed()` now use `values` and `type`: they read
  `uc_d` and `s_l` from `.MxHelperLDL()` (they read names it does not
  return, so the matrix was always the identity).
- [`MxHelperDiagMxMatrix()`](https://ijapesigan.github.io/mxHelper/reference/MxHelperDiagMxMatrix.md)
  and `.MxHelperDiagMxMatrix()` with `vec = FALSE` return the matrix
  only (they stopped with an `mxMatrix()` error).
- The `# nolint` comments on the headers of the ten `SigmaFromLDL` and
  `SigmaDiagFromLDL` files no longer run over 80 characters.

## mxHelper 0.0.2

### Patch

- Removed every [`return()`](https://rdrr.io/r/base/function.html) from
  the nine internal functions that used it
  (`.MxHelperEnsureGoodHessian()`, `.MxHelperNeedsRescue()`,
  `.MxHelperHasPdHessian()`, `.MxHelperIsGoodFit()`, `.MxHelperRun()`,
  `.MxHelperQuiet()`, `.RobustSE()`, `.MxHelperRelaxBounds()`,
  `.MxHelperRelaxBoundsAtBounds()`): early exits became `if`/`else`
  branches with the same results; the 236 tests of push 1 pass
  unchanged.
- Tests for the 15 input-check functions (`.CheckCodes()` to
  `.CheckVal()`).
- Lines wrapped to 80 characters, `nolint` lists completed
  (`object_length_linter`).

## mxHelper 0.0.1

### Patch

- First release as a package: the rProject template, complete roxygen,
  and an exported version with input checks of each of the 58 functions.
- Tests for every function, on the code as imported.
- The two files that held two functions are split
  (`mxHelper-inv-softplus-dot.R`, `mxHelper-inv-ldl-dot.R`);
  `mxHelper-force-hessian-options.R` is now `-dot.R`, and
  `mxHelper-check-status-code-dot.R` is `mxHelper-status-code-check.R`.
