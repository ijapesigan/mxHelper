## ---- test-mxHelper-mx-helper-read-run-save
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "fits the model in a file and saves it"),
      code = {
        input <- tempfile(fileext = ".rds")
        saveRDS(object = .TestModel(), file = input)
        fit <- .MxHelperReadRunSave(
          input = input,
          tries_explore = 2,
          tries_local = 2,
          max_attempts = 2,
          silent = TRUE
        )
        testthat::expect_equal(
          object = fit$output$status$code,
          expected = 0
        )
        testthat::expect_equal(
          object = readRDS(file = input)$output$fit,
          expected = fit$output$fit
        )
        unlink(x = input)
      }
    )
    testthat::test_that(
      desc = paste(text, "records an error instead of throwing it"),
      code = {
        out <- .MxHelperReadRunSave(input = tempfile(), silent = TRUE)
        testthat::expect_true(
          object = is.character(x = attr(x = out, which = "mx_fit_error"))
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperReadRunSave(
            input = tempfile()
          ),
          regexp = "`input` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-read-run-save"
)
