## ---- test-mxHelper-mx-helper-ldl
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "decomposes the matrix"),
      code = {
        x <- matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
        out <- .MxHelperLDL(x = x)
        testthat::expect_equal(
          object = out$l %*% diag(x = out$d) %*% t(x = out$l),
          expected = x
        )
        testthat::expect_equal(
          object = out$d,
          expected = c(2, 0.875)
        )
        testthat::expect_equal(
          object = out$s_l,
          expected = out$l - diag(x = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperLDL(
            x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
          ),
          expected = .MxHelperLDL(
            x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperLDL(
            x = c(1, 2)
          ),
          regexp = "`x` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-ldl"
)
