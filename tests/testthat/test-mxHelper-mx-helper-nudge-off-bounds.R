## ---- test-mxHelper-mx-helper-nudge-off-bounds
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "moves only the estimate at the bound, inward"),
      code = {
        model <- .TestAtBound()
        before <- OpenMx::omxGetParameters(model = model)
        after <- OpenMx::omxGetParameters(
          model = .MxHelperNudgeOffBounds(x = model)
        )
        moved <- after != before
        testthat::expect_equal(
          object = names(x = which(x = moved)),
          expected = "test.l[2,1]"
        )
        testthat::expect_true(
          object = after[["test.l[2,1]"]] > before[["test.l[2,1]"]]
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperNudgeOffBounds(
            x = .TestAtBound()
          ),
          expected = .MxHelperNudgeOffBounds(
            x = .TestAtBound()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperNudgeOffBounds(
            x = .TestAtBound(),
            mult = -1
          ),
          regexp = "`mult` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-nudge-off-bounds"
)
