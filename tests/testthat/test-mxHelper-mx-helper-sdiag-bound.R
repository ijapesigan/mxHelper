## ---- test-mxHelper-mx-helper-sdiag-bound
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSdiagBound(
            p = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = matrix(data = c(NA, -1, NA, NA), nrow = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSdiagBound(
            p = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = .MxHelperSdiagBound(
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
          object = MxHelperSdiagBound(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sdiag-bound"
)
