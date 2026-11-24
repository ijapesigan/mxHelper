## ---- test-mxHelper-mx-helper-is-good-fit
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts a converged fit, rejects an unfitted one"),
      code = {
        testthat::expect_true(
          object = .MxHelperIsGoodFit(x = .TestFit())
        )
        testthat::expect_false(
          object = .MxHelperIsGoodFit(x = .TestModel())
        )
        testthat::expect_false(
          object = .MxHelperIsGoodFit(x = .TestFit(), ok_codes = 1L)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperIsGoodFit(
            x = .TestFit()
          ),
          expected = .MxHelperIsGoodFit(
            x = .TestFit()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperIsGoodFit(
            x = .TestFit(),
            ok_codes = 0.5
          ),
          regexp = "`ok_codes` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-is-good-fit"
)
