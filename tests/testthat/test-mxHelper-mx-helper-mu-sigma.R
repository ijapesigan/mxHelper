## ---- test-mxHelper-mx-helper-mu-sigma
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "fits the means and the covariance matrix"),
      code = {
        x <- .TestData()
        fit <- .MxHelperQuiet(
          expr = .MxHelperMuSigma(x = x, extraTries = 2)
        )
        testthat::expect_equal(
          object = fit$output$status$code,
          expected = 0
        )
        testthat::expect_equal(
          object = unname(
            obj = c(OpenMx::mxEval(expression = mu, model = fit))
          ),
          expected = unname(obj = colMeans(x = x)),
          tolerance = 1e-3
        )
        testthat::expect_equal(
          object = unname(
            obj = OpenMx::mxEval(expression = sigma, model = fit)
          ),
          expected = unname(obj = stats::cov(x = x) * 99 / 100),
          tolerance = 1e-3
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperMuSigma(
            x = c(1, 2, 3)
          ),
          regexp = "`x` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-mu-sigma"
)
