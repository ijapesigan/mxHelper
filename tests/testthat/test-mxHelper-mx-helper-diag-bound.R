## ---- test-mxHelper-mx-helper-diag-bound
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected vector"),
      code = {
        testthat::expect_equal(
          object = .MxHelperDiagBound(
            p = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = c(0, 0)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperDiagBound(
            p = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = .MxHelperDiagBound(
            p = 2,
            val = c(0, -1, 0, 0)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperDiagBound(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-diag-bound"
)
