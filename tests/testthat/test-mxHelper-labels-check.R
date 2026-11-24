## ---- test-mxHelper-labels-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts NULL and character labels"),
      code = {
        testthat::expect_invisible(
          call = .CheckLabels(x = NULL, arg = "labels")
        )
        testthat::expect_null(
          object = .CheckLabels(x = c("a", "b"), arg = "labels")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects NA and non-character input"),
      code = {
        testthat::expect_error(
          object = .CheckLabels(x = c("a", NA), arg = "labels"),
          regexp = "`labels` must be NULL or a character vector"
        )
        testthat::expect_error(
          object = .CheckLabels(x = 1, arg = "labels"),
          regexp = "character vector"
        )
      }
    )
  },
  text = "test-mxHelper-labels-check"
)
