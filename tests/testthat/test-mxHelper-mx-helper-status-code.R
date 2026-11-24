## ---- test-mxHelper-mx-helper-status-code
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns the code and stops without one"),
      code = {
        testthat::expect_equal(
          object = .CheckStatusCode(model = .TestFit()),
          expected = 0
        )
        testthat::expect_error(
          object = .CheckStatusCode(model = .TestModel()),
          regexp = "No OpenMx status code"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version returns the code visibly"),
      code = {
        testthat::expect_visible(
          call = MxHelperStatusCode(model = .TestFit())
        )
        testthat::expect_equal(
          object = MxHelperStatusCode(model = .TestFit()),
          expected = 0
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperStatusCode(
            model = "fit"
          ),
          regexp = "`model` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-status-code"
)
