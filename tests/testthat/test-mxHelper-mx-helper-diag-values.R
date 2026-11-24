## ---- test-mxHelper-mx-helper-diag-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected vector"),
      code = {
        testthat::expect_equal(
          object = .MxHelperDiagValues(
            p = 2,
            val = c(1, 2, 3, 4)
          ),
          expected = c(1, 4)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperDiagValues(
            p = 2,
            val = c(1, 2, 3, 4)
          ),
          expected = .MxHelperDiagValues(
            p = 2,
            val = c(1, 2, 3, 4)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperDiagValues(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-diag-values"
)
