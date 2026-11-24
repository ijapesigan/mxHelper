## ---- test-mxHelper-mx-helper-dtvar-beta-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns a stable transition matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperDTVARBetaValues(p = 2, val = NULL),
          expected = diag(x = 0.001, nrow = 2)
        )
        out <- .MxHelperDTVARBetaValues(p = 2, val = c(1.2, 0, 0, 0.5))
        testthat::expect_true(
          object = all(Mod(z = eigen(x = out)$values) < 1)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperDTVARBetaValues(
            p = 2,
            val = c(0.5, 0, 0, 0.5)
          ),
          expected = .MxHelperDTVARBetaValues(
            p = 2,
            val = c(0.5, 0, 0, 0.5)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperDTVARBetaValues(
            p = -1,
            val = NULL
          ),
          regexp = "`p` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-dtvar-beta-values"
)
