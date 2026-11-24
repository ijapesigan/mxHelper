## ---- test-mxHelper-numeric-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts numeric vectors"),
      code = {
        testthat::expect_invisible(
          call = .CheckNumeric(x = c(1, 2), arg = "v")
        )
        testthat::expect_null(
          object = .CheckNumeric(x = 1L, arg = "v")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects NA, empty, and non-numeric input"),
      code = {
        testthat::expect_error(
          object = .CheckNumeric(x = c(1, NA), arg = "v"),
          regexp = "`v` must be a numeric vector without NA"
        )
        testthat::expect_error(
          object = .CheckNumeric(x = numeric(length = 0), arg = "v"),
          regexp = "numeric vector"
        )
        testthat::expect_error(
          object = .CheckNumeric(x = "a", arg = "v"),
          regexp = "numeric vector"
        )
      }
    )
  },
  text = "test-mxHelper-numeric-check"
)
