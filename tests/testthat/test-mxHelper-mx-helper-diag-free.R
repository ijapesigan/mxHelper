## ---- test-mxHelper-mx-helper-diag-free
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected vector"),
      code = {
        testthat::expect_equal(
          object = .MxHelperDiagFree(
            p = 2,
            val = NULL
          ),
          expected = c(TRUE, TRUE)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperDiagFree(
            p = 2,
            val = NULL
          ),
          expected = .MxHelperDiagFree(
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
          object = MxHelperDiagFree(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-diag-free"
)
