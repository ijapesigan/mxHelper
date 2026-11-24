## ---- test-mxHelper-mx-helper-diag-labels
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the expected labels"),
      code = {
        testthat::expect_equal(
          object = .MxHelperDiagLabels(
            p = 2,
            name = "b",
            sep = "underscore"
          ),
          expected = c("b_1_1", "b_2_2")
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperDiagLabels(
            p = 2,
            name = "b",
            sep = "underscore"
          ),
          expected = .MxHelperDiagLabels(
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
          object = MxHelperDiagLabels(
            p = 2,
            name = "b",
            sep = "dot"
          ),
          regexp = "`sep` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-diag-labels"
)
