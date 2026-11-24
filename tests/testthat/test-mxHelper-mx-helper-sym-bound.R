## ---- test-mxHelper-mx-helper-sym-bound
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSymBound(
            p = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = matrix(data = c(0, -1, -1, 0), nrow = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSymBound(
            p = 2,
            val = c(0, -1, 0, 0)
          ),
          expected = .MxHelperSymBound(
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
          object = MxHelperSymBound(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sym-bound"
)
