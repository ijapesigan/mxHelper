## ---- test-mxHelper-mx-helper-force-hessian-options
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "sets both Hessian options"),
      code = {
        model <- .MxHelperForceHessianOptions(model = .TestModel())
        testthat::expect_equal(
          object = model@options[c("Calculate Hessian", "Hessian")],
          expected = list(`Calculate Hessian` = "Yes", Hessian = "Yes")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperForceHessianOptions(
            model = .TestModel()
          ),
          expected = .MxHelperForceHessianOptions(
            model = .TestModel()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperForceHessianOptions(
            model = list()
          ),
          regexp = "`model` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-force-hessian-options"
)
