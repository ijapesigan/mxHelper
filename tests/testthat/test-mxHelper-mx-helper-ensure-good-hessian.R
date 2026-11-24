## ---- test-mxHelper-mx-helper-ensure-good-hessian
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns a fit that meets the criteria"),
      code = {
        fit <- .MxHelperEnsureGoodHessian(
          model = .TestModel(),
          tries_explore = 2,
          tries_local = 2,
          max_attempts = 2
        )
        testthat::expect_true(
          object = .MxHelperIsGoodFit(x = fit)
        )
        testthat::expect_true(
          object = .MxHelperHasPdHessian(x = fit)
        )
        testthat::expect_identical(
          object = .MxHelperEnsureGoodHessian(model = 1),
          expected = 1
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperEnsureGoodHessian(
            model = .TestFit()
          ),
          expected = .MxHelperEnsureGoodHessian(
            model = .TestFit()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperEnsureGoodHessian(
            model = .TestFit(),
            factor = 0
          ),
          regexp = "`factor` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-ensure-good-hessian"
)
