## ---- test-mxHelper-mx-helper-needs-rescue
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "needs a rescue only when a criterion fails"),
      code = {
        testthat::expect_false(
          object = .MxHelperNeedsRescue(model = .TestFit())
        )
        testthat::expect_true(
          object = .MxHelperNeedsRescue(model = .TestModel())
        )
        testthat::expect_true(
          object = .MxHelperNeedsRescue(model = .TestAtBound())
        )
        testthat::expect_true(
          object = .MxHelperNeedsRescue(model = 1)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "passes nd_tol on to the good-fit test"),
      code = {
        testthat::expect_false(
          object = .MxHelperNeedsRescue(model = .TestFitSmall())
        )
        testthat::expect_true(
          object = .MxHelperNeedsRescue(
            model = .TestFitSmall(),
            nd_tol = NULL
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperNeedsRescue(
            model = .TestFit()
          ),
          expected = .MxHelperNeedsRescue(
            model = .TestFit()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperNeedsRescue(
            model = .TestFit(),
            check_condition = 1
          ),
          regexp = "`check_condition` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-needs-rescue"
)
