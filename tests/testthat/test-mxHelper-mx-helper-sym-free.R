## ---- test-mxHelper-mx-helper-sym-free
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSymFree(
            p = 2,
            val = NULL
          ),
          expected = matrix(data = TRUE, nrow = 2, ncol = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSymFree(
            p = 2,
            val = NULL
          ),
          expected = .MxHelperSymFree(
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
          object = MxHelperSymFree(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sym-free"
)
