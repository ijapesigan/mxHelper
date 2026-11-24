## ---- test-mxHelper-mx-helper-full-bound
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperFullBound(
            m = 2,
            n = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = matrix(data = c(0, -1, 0, 0), nrow = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperFullBound(
            m = 2,
            n = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = .MxHelperFullBound(
            m = 2,
            n = 2,
            val = c(0, -1, 0, 0)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperFullBound(
            m = 2,
            n = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-full-bound"
)
