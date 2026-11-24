## ---- test-mxHelper-mx-helper-dtvar-alpha-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns a column vector"),
      code = {
        testthat::expect_equal(
          object = .MxHelperDTVARAlphaValues(p = 2, val = NULL),
          expected = matrix(data = 0, nrow = 2, ncol = 1)
        )
        testthat::expect_equal(
          object = .MxHelperDTVARAlphaValues(p = 2, val = c(1, 2)),
          expected = matrix(data = c(1, 2), nrow = 2, ncol = 1)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperDTVARAlphaValues(
            p = 2,
            val = c(1, 2)
          ),
          expected = .MxHelperDTVARAlphaValues(
            p = 2,
            val = c(1, 2)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperDTVARAlphaValues(
            p = 2,
            val = TRUE
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-dtvar-alpha-values"
)
