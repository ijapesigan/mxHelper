## ---- test-mxHelper-mx-helper-read-run-save-no-hessian
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "fits the model in a file without the Hessian"),
      code = {
        input <- tempfile(fileext = ".rds")
        saveRDS(object = .TestModel(), file = input)
        fit <- .MxHelperQuiet(
          expr = .MxHelperReadRunSaveNoHessian(
            input = input,
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
        unlink(x = input)
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperReadRunSaveNoHessian(
            input = 1
          ),
          regexp = "`input` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-read-run-save-no-hessian"
)
