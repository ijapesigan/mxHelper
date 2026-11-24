## ---- test-mxHelper-mx-helper-relax-bounds-at-bounds
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "relaxes only the actionable bound that is hit"),
      code = {
        model <- .TestAtBound()
        lb <- OpenMx::omxGetParameters(model = model, fetch = "lbound")
        out <- OpenMx::omxGetParameters(
          model = .MxHelperRelaxBoundsAtBounds(x = model),
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
          model = .MxHelperRelaxBoundsAtBounds(
            x = model,
            exclude = "test.l[2,1]"
          ),
          fetch = "lbound"
        )
        testthat::expect_equal(
          object = excluded,
          expected = lb
        )
        allowed <- OpenMx::omxGetParameters(
          model = .MxHelperRelaxBoundsAtBounds(
            x = model,
            allowed_bounds = list(lower = "test.l[2,1]")
          ),
          fetch = "lbound"
        )
        testthat::expect_equal(
          object = allowed,
          expected = lb
        )
        testthat::expect_error(
          object = .MxHelperRelaxBoundsAtBounds(x = model, factor = 1),
          regexp = "factor > 1"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperRelaxBoundsAtBounds(
            x = .TestAtBound()
          ),
          expected = .MxHelperRelaxBoundsAtBounds(
            x = .TestAtBound()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperRelaxBoundsAtBounds(
            x = .TestAtBound(),
            protect_lb_zero = NULL
          ),
          regexp = "`protect_lb_zero` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-relax-bounds-at-bounds"
)
