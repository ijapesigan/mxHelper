## ---- test-mxHelper-status-code-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns the status code of a converged fit"),
      code = {
        fit <- .TestFit()
        testthat::expect_identical(
          object = .CheckStatusCode(model = fit),
          expected = fit@output$status$code
        )
        testthat::expect_invisible(
          call = .CheckStatusCode(model = fit)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "stops when there is no status code"),
      code = {
        testthat::expect_error(
          object = .CheckStatusCode(model = .TestModel(), context = "m"),
          regexp = "No OpenMx status code found in `m`"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "stops when the status code is not a single number"),
      code = {
        model <- .TestModel()
        model@output <- list(status = list(code = c(1, 2)))
        testthat::expect_error(
          object = .CheckStatusCode(model = model, context = "m"),
          regexp = "not a single non-NA numeric value"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "warns with the details when the code is not 0"),
      code = {
        model <- .TestModel()
        model@output <- list(status = list(code = 6, details = "bad"))
        testthat::expect_warning(
          object = .CheckStatusCode(model = model, context = "m"),
          regexp = "status code 6 for `m`: bad"
        )
        model@output <- list(status = list(code = 5, details = ""))
        testthat::expect_warning(
          object = .CheckStatusCode(model = model, context = "m"),
          regexp = "No status details provided"
        )
      }
    )
  },
  text = "test-mxHelper-status-code-check"
)
