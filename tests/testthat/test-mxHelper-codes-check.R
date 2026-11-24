## ---- test-mxHelper-codes-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts whole numbers and returns invisible NULL"),
      code = {
        testthat::expect_invisible(
          call = .CheckCodes(x = c(0, 1, 6), arg = "k")
        )
        testthat::expect_null(
          object = .CheckCodes(x = 1L, arg = "k")
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "rejects non-whole, non-finite, empty, and",
        "non-numeric input"
      ),
      code = {
        testthat::expect_error(
          object = .CheckCodes(x = 0.5, arg = "k"),
          regexp = "`k` must be a vector of whole numbers"
        )
        testthat::expect_error(
          object = .CheckCodes(x = NA_real_, arg = "k"),
          regexp = "whole numbers"
        )
        testthat::expect_error(
          object = .CheckCodes(x = numeric(length = 0), arg = "k"),
          regexp = "whole numbers"
        )
        testthat::expect_error(
          object = .CheckCodes(x = "a", arg = "k"),
          regexp = "whole numbers"
        )
      }
    )
  },
  text = "test-mxHelper-codes-check"
)
