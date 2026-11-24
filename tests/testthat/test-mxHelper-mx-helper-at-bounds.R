## ---- test-mxHelper-mx-helper-at-bounds
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "finds the estimate at its lower bound"),
      code = {
        out <- .MxHelperAtBounds(x = .TestAtBound())
        testthat::expect_true(
          object = out$actionable
        )
        testthat::expect_equal(
          object = names(x = which(x = out$at_lb)),
          expected = "test.l[2,1]"
        )
        allowed <- .MxHelperAtBounds(
          x = .TestAtBound(),
          allowed_bounds = list(lower = "test.l[2,1]")
        )
        testthat::expect_true(
          object = allowed$any
        )
        testthat::expect_false(
          object = allowed$actionable
        )
        testthat::expect_false(
          object = .MxHelperAtBounds(x = .TestFit())$any
        )
        testthat::expect_error(
          object = .MxHelperAtBounds(
            x = .TestFit(),
            allowed_bounds = list(lower = "nope")
          ),
          regexp = "Unknown parameter"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperAtBounds(
            x = .TestAtBound()
          ),
          expected = .MxHelperAtBounds(
            x = .TestAtBound()
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperAtBounds(
            x = .TestFit(),
            abs_bnd_tol = 0
          ),
          regexp = "`abs_bnd_tol` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-at-bounds"
)
