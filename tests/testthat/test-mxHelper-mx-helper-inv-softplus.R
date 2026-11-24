## ---- test-mxHelper-mx-helper-inv-softplus
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "inverts the softplus"),
      code = {
        x <- c(-5, 0, 2, 25, 40)
        testthat::expect_equal(
          object = .MxHelperInvSoftplus(x = .MxHelperSoftplus(x = x)),
          expected = x
        )
        testthat::expect_error(
          object = .MxHelperInvSoftplus(x = 0),
          regexp = "strictly positive"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperInvSoftplus(
            x = c(0.5, 1, 2)
          ),
          expected = .MxHelperInvSoftplus(
            x = c(0.5, 1, 2)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperInvSoftplus(
            x = NA
          ),
          regexp = "`x` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-inv-softplus"
)
