## ---- test-mxHelper-mx-helper-sym-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSymValues(
            p = 2,
            val = c(1, 2, 3, 4)
          ),
          expected = matrix(data = c(1, 2, 2, 4), nrow = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSymValues(
            p = 2,
            val = c(1, 2, 3, 4)
          ),
          expected = .MxHelperSymValues(
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
          object = MxHelperSymValues(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sym-values"
)
