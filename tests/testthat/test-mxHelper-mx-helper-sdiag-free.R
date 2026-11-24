## ---- test-mxHelper-mx-helper-sdiag-free
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected matrix"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSdiagFree(
            p = 2,
            val = NULL
          ),
          expected = matrix(data = c(FALSE, TRUE, FALSE, FALSE), nrow = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSdiagFree(
            p = 2,
            val = NULL
          ),
          expected = .MxHelperSdiagFree(
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
          object = MxHelperSdiagFree(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sdiag-free"
)
