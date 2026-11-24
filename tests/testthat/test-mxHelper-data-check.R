## ---- test-mxHelper-data-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts a data frame and a named numeric matrix"),
      code = {
        testthat::expect_invisible(
          call = .CheckData(x = .TestData())
        )
        testthat::expect_null(
          object = .CheckData(x = as.matrix(x = .TestData()))
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects unnamed, short, and non-numeric input"),
      code = {
        testthat::expect_error(
          object = .CheckData(x = unname(obj = as.matrix(x = .TestData()))),
          regexp = "`x` must be a data frame"
        )
        testthat::expect_error(
          object = .CheckData(x = .TestData()[1, ]),
          regexp = "at least two rows"
        )
        testthat::expect_error(
          object = .CheckData(x = 1:3),
          regexp = "`x` must be a data frame"
        )
        testthat::expect_error(
          object = .CheckData(
            x = matrix(
              data = "a",
              nrow = 2,
              ncol = 2,
              dimnames = list(NULL, c("a", "b"))
            )
          ),
          regexp = "numeric matrix"
        )
      }
    )
  },
  text = "test-mxHelper-data-check"
)
