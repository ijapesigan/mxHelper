## ---- test-mxHelper-mx-model-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts an OpenMx model"),
      code = {
        testthat::expect_invisible(
          call = .CheckMxModel(x = .TestModel(), arg = "model")
        )
        testthat::expect_null(
          object = .CheckMxModel(x = .TestModel(), arg = "model")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects other objects"),
      code = {
        testthat::expect_error(
          object = .CheckMxModel(x = list(), arg = "model"),
          regexp = "`model` must be an OpenMx model"
        )
        testthat::expect_error(
          object = .CheckMxModel(x = NULL, arg = "model"),
          regexp = "OpenMx model"
        )
      }
    )
  },
  text = "test-mxHelper-mx-model-check"
)
