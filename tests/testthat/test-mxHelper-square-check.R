## ---- test-mxHelper-square-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts square numeric matrices, k = 1 and 2"),
      code = {
        testthat::expect_invisible(
          call = .CheckSquare(x = diag(x = 2), arg = "m")
        )
        testthat::expect_null(
          object = .CheckSquare(x = matrix(data = 1), arg = "m")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects non-square, NA, and non-matrix input"),
      code = {
        testthat::expect_error(
          object = .CheckSquare(
            x = matrix(data = 1, nrow = 2, ncol = 3),
            arg = "m"
          ),
          regexp = "`m` must be a square numeric matrix"
        )
        testthat::expect_error(
          object = .CheckSquare(
            x = matrix(data = NA_real_, nrow = 2, ncol = 2),
            arg = "m"
          ),
          regexp = "square numeric matrix"
        )
        testthat::expect_error(
          object = .CheckSquare(x = 1, arg = "m"),
          regexp = "square numeric matrix"
        )
      }
    )
  },
  text = "test-mxHelper-square-check"
)
