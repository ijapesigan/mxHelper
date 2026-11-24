## ---- test-mxHelper-mx-helper-ctvar-beta-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns a stable drift matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperCTVARBetaValues(p = 2, val = NULL),
          expected = diag(x = -0.1, nrow = 2)
        )
        out <- .MxHelperCTVARBetaValues(p = 2, val = c(0.5, 0, 0, -0.2))
        testthat::expect_true(
          object = all(Re(z = eigen(x = out)$values) < 0)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperCTVARBetaValues(
            p = 2,
            val = NULL
          ),
          expected = .MxHelperCTVARBetaValues(
            p = 2,
            val = NULL
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperCTVARBetaValues(
            p = 2,
            val = list(1)
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-ctvar-beta-values"
)
