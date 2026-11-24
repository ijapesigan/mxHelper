## ---- test-mxHelper-mx-helper-run
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "fits a model and keeps a good fit"),
      code = {
        fit <- .MxHelperRun(model = .TestModel(), silent = TRUE)
        testthat::expect_equal(
          object = fit$output$status$code,
          expected = 0
        )
        good <- .TestFit()
        testthat::expect_identical(
          object = .MxHelperRun(model = good, silent = TRUE),
          expected = good
        )
        testthat::expect_null(
          object = .MxHelperRun(model = 1)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperRun(
            model = .TestFit()
          ),
          expected = .MxHelperRun(
            model = .TestFit()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperRun(
            model = .TestFit(),
            grad_tol = -1
          ),
          regexp = "`grad_tol` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-run"
)
