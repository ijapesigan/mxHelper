## ---- test-mxHelper-mx-helper-relax-bounds
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "relaxes only the bound that is hit"),
      code = {
        model <- .TestAtBound()
        lb <- OpenMx::omxGetParameters(model = model, fetch = "lbound")
        out <- OpenMx::omxGetParameters(
          model = .MxHelperRelaxBounds(x = model),
          fetch = "lbound"
        )
        testthat::expect_equal(
          object = out[["test.l[2,1]"]],
          expected = lb[["test.l[2,1]"]] / 10
        )
        testthat::expect_equal(
          object = out[names(x = out) != "test.l[2,1]"],
          expected = lb[names(x = lb) != "test.l[2,1]"]
        )
        excluded <- OpenMx::omxGetParameters(
          model = .MxHelperRelaxBounds(x = model, exclude = "test.l[2,1]"),
          fetch = "lbound"
        )
        testthat::expect_equal(
          object = excluded,
          expected = lb
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperRelaxBounds(
            x = .TestAtBound()
          ),
          expected = .MxHelperRelaxBounds(
            x = .TestAtBound()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperRelaxBounds(
            x = .TestAtBound(),
            labels = 1
          ),
          regexp = "`labels` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-relax-bounds"
)
