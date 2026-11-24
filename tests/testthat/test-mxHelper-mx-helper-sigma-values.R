## ---- test-mxHelper-mx-helper-sigma-values
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "keeps a PD matrix and repairs a singular one"),
      code = {
        testthat::expect_equal(
          object = .MxHelperSigmaValues(p = 2, val = NULL),
          expected = diag(x = 2)
        )
        testthat::expect_equal(
          object = .MxHelperSigmaValues(p = 2, val = c(1, 0.5, 0.5, 1)),
          expected = matrix(data = c(1, 0.5, 0.5, 1), nrow = 2)
        )
        out <- .MxHelperSigmaValues(p = 2, val = c(1, -1, -1, 1) * 2)
        testthat::expect_true(
          object = min(eigen(x = out, only.values = TRUE)$values) > -1e-8
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSigmaValues(
            p = 2,
            val = c(2, 0.5, 0.5, 1)
          ),
          expected = .MxHelperSigmaValues(
            p = 2,
            val = c(2, 0.5, 0.5, 1)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSigmaValues(
            p = 2,
            val = "a"
          ),
          regexp = "`val` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sigma-values"
)
