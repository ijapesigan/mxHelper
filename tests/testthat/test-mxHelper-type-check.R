## ---- test-mxHelper-type-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts NULL and the three types"),
      code = {
        testthat::expect_invisible(
          call = .CheckType(x = NULL)
        )
        testthat::expect_null(
          object = .CheckType(x = "zero")
        )
        testthat::expect_null(
          object = .CheckType(x = "identity")
        )
        testthat::expect_null(
          object = .CheckType(x = "diffused")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects other values"),
      code = {
        testthat::expect_error(
          object = .CheckType(x = "other"),
          regexp = "`type` must be NULL"
        )
        testthat::expect_error(
          object = .CheckType(x = 1),
          regexp = "`type` must be NULL"
        )
        testthat::expect_error(
          object = .CheckType(x = c("zero", "identity")),
          regexp = "`type` must be NULL"
        )
      }
    )
  },
  text = "test-mxHelper-type-check"
)
