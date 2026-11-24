## ---- test-mxHelper-mx-helper-robust-se
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "computes robust standard errors"),
      code = {
        out <- .RobustSE(model = .TestFit())
        testthat::expect_named(
          object = out,
          expected = c("SE", "cov", "bread", "meat", "TIC")
        )
        testthat::expect_true(
          object = all(out$SE > 0)
        )
        testthat::expect_null(
          object = .RobustSE(model = "a")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperRobustSE(
            model = .TestFit()
          ),
          expected = .RobustSE(
            model = .TestFit()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperRobustSE(
            model = NULL
          ),
          regexp = "`model` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-robust-se"
)
