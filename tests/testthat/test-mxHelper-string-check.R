## ---- test-mxHelper-string-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts a non-empty string"),
      code = {
        testthat::expect_invisible(
          call = .CheckString(x = "a", arg = "s")
        )
        testthat::expect_null(
          object = .CheckString(x = "abc", arg = "s")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects empty, NA, vectors, and non-character input"),
      code = {
        testthat::expect_error(
          object = .CheckString(x = "", arg = "s"),
          regexp = "`s` must be a single non-empty character string"
        )
        testthat::expect_error(
          object = .CheckString(x = NA_character_, arg = "s"),
          regexp = "non-empty"
        )
        testthat::expect_error(
          object = .CheckString(x = c("a", "b"), arg = "s"),
          regexp = "non-empty"
        )
        testthat::expect_error(
          object = .CheckString(x = 1, arg = "s"),
          regexp = "non-empty"
        )
      }
    )
  },
  text = "test-mxHelper-string-check"
)
