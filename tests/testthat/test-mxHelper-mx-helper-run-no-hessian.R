## ---- test-mxHelper-mx-helper-run-no-hessian
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "fits a model without the Hessian"),
      code = {
        fit <- .MxHelperQuiet(
          expr = .MxHelperRunNoHessian(
            model = .TestModel(),
            tries_explore = 2,
            silent = TRUE
          )
        )
        testthat::expect_equal(
          object = fit$output$status$code,
          expected = 0
        )
        testthat::expect_null(
          object = fit$output$hessian
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperRunNoHessian(
            model = .TestModel(),
            tries_explore = 0,
            silent = TRUE
          ),
          regexp = "`tries_explore` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-run-no-hessian"
)
