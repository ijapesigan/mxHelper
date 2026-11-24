## ---- test-mxHelper-val-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(
        text,
        "accepts NULL, numeric and logical vectors and",
        "matrices, and all-NA when allowed"
      ),
      code = {
        testthat::expect_invisible(
          call = .CheckVal(x = NULL, arg = "v", mode = "numeric", na = FALSE)
        )
        testthat::expect_null(
          object = .CheckVal(
            x = c(1, 2),
            arg = "v",
            mode = "numeric",
            na = FALSE
          )
        )
        testthat::expect_null(
          object = .CheckVal(
            x = diag(x = 2),
            arg = "v",
            mode = "numeric",
            na = FALSE
          )
        )
        testthat::expect_null(
          object = .CheckVal(
            x = c(TRUE, FALSE),
            arg = "v",
            mode = "logical",
            na = FALSE
          )
        )
        testthat::expect_null(
          object = .CheckVal(x = NA, arg = "v", mode = "numeric", na = TRUE)
        )
        testthat::expect_null(
          object = .CheckVal(
            x = c(1, NA),
            arg = "v",
            mode = "numeric",
            na = TRUE
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "rejects the wrong mode, NA when not allowed, and",
        "empty input"
      ),
      code = {
        testthat::expect_error(
          object = .CheckVal(x = "a", arg = "v", mode = "numeric", na = FALSE),
          regexp = "`v` must be NULL, or a numeric vector or matrix"
        )
        testthat::expect_error(
          object = .CheckVal(
            x = c(1, NA),
            arg = "v",
            mode = "numeric",
            na = FALSE
          ),
          regexp = "numeric vector or matrix"
        )
        testthat::expect_error(
          object = .CheckVal(x = 1, arg = "v", mode = "logical", na = FALSE),
          regexp = "logical vector or matrix"
        )
        testthat::expect_error(
          object = .CheckVal(
            x = numeric(length = 0),
            arg = "v",
            mode = "numeric",
            na = FALSE
          ),
          regexp = "numeric vector or matrix"
        )
      }
    )
  },
  text = "test-mxHelper-val-check"
)
