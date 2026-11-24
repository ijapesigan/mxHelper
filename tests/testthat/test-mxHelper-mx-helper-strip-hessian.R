## ---- test-mxHelper-mx-helper-strip-hessian
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "turns off standard errors and adds a compute plan"),
      code = {
        model <- .MxHelperStripHessian(model = .TestModel())
        testthat::expect_equal(
          object = model@options[["Standard Errors"]],
          expected = "No"
        )
        testthat::expect_s4_class(
          object = model@compute,
          class = "MxComputeSequence"
        )
        fit <- OpenMx::mxRun(model = model, silent = TRUE)
        testthat::expect_null(
          object = fit$output$hessian
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperStripHessian(
            model = .TestModel()
          ),
          expected = .MxHelperStripHessian(
            model = .TestModel()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperStripHessian(
            model = 1
          ),
          regexp = "`model` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-strip-hessian"
)
