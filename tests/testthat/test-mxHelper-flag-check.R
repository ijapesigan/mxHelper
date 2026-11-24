## ---- test-mxHelper-flag-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts TRUE and FALSE"),
      code = {
        testthat::expect_invisible(
          call = .CheckFlag(x = TRUE, arg = "f")
        )
        testthat::expect_null(
          object = .CheckFlag(x = FALSE, arg = "f")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects NA, vectors, and non-logical input"),
      code = {
        testthat::expect_error(
          object = .CheckFlag(x = NA, arg = "f"),
          regexp = "`f` must be a single TRUE or FALSE"
        )
        testthat::expect_error(
          object = .CheckFlag(x = c(TRUE, FALSE), arg = "f"),
          regexp = "TRUE or FALSE"
        )
        testthat::expect_error(
          object = .CheckFlag(x = 1, arg = "f"),
          regexp = "TRUE or FALSE"
        )
      }
    )
  },
  text = "test-mxHelper-flag-check"
)
