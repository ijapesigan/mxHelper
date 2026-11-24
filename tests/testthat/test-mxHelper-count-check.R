## ---- test-mxHelper-count-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts a single positive integer"),
      code = {
        testthat::expect_invisible(
          call = .CheckCount(x = 1, arg = "p")
        )
        testthat::expect_null(
          object = .CheckCount(x = 2L, arg = "p")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects zero, fractions, vectors, NA, and text"),
      code = {
        testthat::expect_error(
          object = .CheckCount(x = 0, arg = "p"),
          regexp = "`p` must be a single positive integer"
        )
        testthat::expect_error(
          object = .CheckCount(x = 1.5, arg = "p"),
          regexp = "positive integer"
        )
        testthat::expect_error(
          object = .CheckCount(x = c(1, 2), arg = "p"),
          regexp = "positive integer"
        )
        testthat::expect_error(
          object = .CheckCount(x = NA_real_, arg = "p"),
          regexp = "positive integer"
        )
        testthat::expect_error(
          object = .CheckCount(x = "1", arg = "p"),
          regexp = "positive integer"
        )
      }
    )
  },
  text = "test-mxHelper-count-check"
)
