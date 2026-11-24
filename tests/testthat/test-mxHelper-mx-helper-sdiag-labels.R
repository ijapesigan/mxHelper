## ---- test-mxHelper-mx-helper-sdiag-labels
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected labels"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSdiagLabels(
            p = 2,
            name = "b",
            sep = "underscore"
          ),
          expected = matrix(
            data = c(NA, "b_2_1", NA, NA),
            nrow = 2
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSdiagLabels(
            p = 2,
            name = "b",
            sep = "underscore"
          ),
          expected = .MxHelperSdiagLabels(
            p = 2,
            name = "b",
            sep = "underscore"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSdiagLabels(
            p = 2,
            name = "b",
            sep = "dot"
          ),
          regexp = "`sep` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sdiag-labels"
)
