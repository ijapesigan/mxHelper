## ---- test-mxHelper-mx-helper-softplus
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "computes log(1 + exp(x)) without overflow"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSoftplus(x = c(-2, 0, 2)),
          expected = log1p(x = exp(x = c(-2, 0, 2)))
        )
        testthat::expect_equal(
          object = .MxHelperSoftplus(x = 1000),
          expected = 1000
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSoftplus(
            x = c(-1, 0, 1)
          ),
          expected = .MxHelperSoftplus(
            x = c(-1, 0, 1)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSoftplus(
            x = "a"
          ),
          regexp = "`x` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-softplus"
)
