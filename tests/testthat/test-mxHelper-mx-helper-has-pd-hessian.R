## ---- test-mxHelper-mx-helper-has-pd-hessian
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts a positive definite Hessian"),
      code = {
        testthat::expect_true(
          object = .MxHelperHasPdHessian(x = .TestFit())
        )
        testthat::expect_false(
          object = .MxHelperHasPdHessian(x = .TestModel())
        )
        testthat::expect_false(
          object = .MxHelperHasPdHessian(
            x = .TestFit(),
            check_condition = TRUE,
            cond_max = 1
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperHasPdHessian(
            x = .TestFit()
          ),
          expected = .MxHelperHasPdHessian(
            x = .TestFit()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperHasPdHessian(
            x = .TestFit(),
            cond_max = Inf
          ),
          regexp = "`cond_max` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-has-pd-hessian"
)
