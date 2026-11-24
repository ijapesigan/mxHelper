## ---- test-mxHelper-sep-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts the two separators"),
      code = {
        testthat::expect_invisible(
          call = .CheckSep(x = "underscore")
        )
        testthat::expect_null(
          object = .CheckSep(x = "bracket")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects other values"),
      code = {
        testthat::expect_error(
          object = .CheckSep(x = "dot"),
          regexp = "`sep` must be"
        )
        testthat::expect_error(
          object = .CheckSep(x = c("underscore", "bracket")),
          regexp = "`sep` must be"
        )
        testthat::expect_error(
          object = .CheckSep(x = NULL),
          regexp = "`sep` must be"
        )
      }
    )
  },
  text = "test-mxHelper-sep-check"
)
