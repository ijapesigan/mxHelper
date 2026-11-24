## ---- test-mxHelper-mx-helper-full-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperFullValues(
            m = 2,
            n = 2,
            val = c(1, 2, 3, 4)
          ),
          expected = matrix(data = c(1, 2, 3, 4), nrow = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperFullValues(
            m = 2,
            n = 2,
            val = c(1, 2, 3, 4)
          ),
          expected = .MxHelperFullValues(
            m = 2,
            n = 2,
            val = c(1, 2, 3, 4)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperFullValues(
            m = 2,
            n = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-full-values"
)
