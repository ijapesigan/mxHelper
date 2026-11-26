## ---- test-mxHelper-non-negative-or-null-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts NULL, zero, and a positive number"),
      code = {
        testthat::expect_invisible(
          call = .CheckNonNegativeOrNull(x = NULL, arg = "a")
        )
        testthat::expect_null(
          object = .CheckNonNegativeOrNull(x = 0, arg = "a")
        )
        testthat::expect_null(
          object = .CheckNonNegativeOrNull(x = 1e-4, arg = "a")
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "rejects negatives, infinity, NA, vectors, and text"
      ),
      code = {
        testthat::expect_error(
          object = .CheckNonNegativeOrNull(x = -1, arg = "a"),
          regexp = "`a` must be NULL or a single non-negative number"
        )
        testthat::expect_error(
          object = .CheckNonNegativeOrNull(x = Inf, arg = "a"),
          regexp = "non-negative number"
        )
        testthat::expect_error(
          object = .CheckNonNegativeOrNull(x = NA_real_, arg = "a"),
          regexp = "non-negative number"
        )
        testthat::expect_error(
          object = .CheckNonNegativeOrNull(x = c(1, 2), arg = "a"),
          regexp = "non-negative number"
        )
        testthat::expect_error(
          object = .CheckNonNegativeOrNull(x = "1", arg = "a"),
          regexp = "non-negative number"
        )
      }
    )
  },
  text = "test-mxHelper-non-negative-or-null-check"
)
