## ---- test-mxHelper-positive-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts a single positive number"),
      code = {
        testthat::expect_invisible(
          call = .CheckPositive(x = 0.5, arg = "a")
        )
        testthat::expect_null(
          object = .CheckPositive(x = 3, arg = "a")
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "rejects zero, negatives, infinity, vectors, and",
        "text"
      ),
      code = {
        testthat::expect_error(
          object = .CheckPositive(x = 0, arg = "a"),
          regexp = "`a` must be a single positive number"
        )
        testthat::expect_error(
          object = .CheckPositive(x = -1, arg = "a"),
          regexp = "positive number"
        )
        testthat::expect_error(
          object = .CheckPositive(x = Inf, arg = "a"),
          regexp = "positive number"
        )
        testthat::expect_error(
          object = .CheckPositive(x = c(1, 2), arg = "a"),
          regexp = "positive number"
        )
        testthat::expect_error(
          object = .CheckPositive(x = "1", arg = "a"),
          regexp = "positive number"
        )
      }
    )
  },
  text = "test-mxHelper-positive-check"
)
