## ---- test-mxHelper-mx-helper-quiet
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "drops printed output and messages"),
      code = {
        testthat::expect_silent(
          object = out <- .MxHelperQuiet(
            expr = {
              message("a message")
              cat("printed\n")
              1
            }
          )
        )
        testthat::expect_equal(
          object = out,
          expected = 1
        )
        testthat::expect_message(
          object = .MxHelperQuiet(expr = message("shown"), silent = FALSE),
          regexp = "shown"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperQuiet(expr = 1 + 1),
          expected = .MxHelperQuiet(expr = 1 + 1)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperQuiet(
            expr = 1,
            silent = NA
          ),
          regexp = "`silent` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-quiet"
)
