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
      desc = paste(text, "reports the criterion that accepted the fit"),
      code = {
        testthat::expect_identical(
          object = attr(
            x = .MxHelperIsGoodFit(x = .TestFit()),
            which = "criterion"
          ),
          expected = "gradient"
        )
        testthat::expect_null(
          object = attributes(x = .MxHelperIsGoodFit(x = .TestModel()))
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "accepts a near-zero-variance fit by its Newton decrement"
      ),
      code = {
        fit <- .TestFitSmall()
        testthat::expect_identical(
          object = fit$output$status$code,
          expected = 0L
        )
        testthat::expect_gt(
          object = max(abs(x = fit$output$gradient)),
          expected = 1e-2
        )
        good <- .MxHelperIsGoodFit(x = fit)
        testthat::expect_true(
          object = good
        )
        testthat::expect_identical(
          object = attr(x = good, which = "criterion"),
          expected = "newton"
        )
        testthat::expect_false(
          object = .MxHelperIsGoodFit(x = fit, nd_tol = NULL)
        )
        testthat::expect_false(
          object = .MxHelperIsGoodFit(x = fit, nd_tol = 0)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "still rejects a fit stopped early"),
      code = {
        testthat::expect_false(
          object = .MxHelperIsGoodFit(
            x = .TestFitEarly(),
            ok_codes = c(0L, 6L)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(
        text,
        "uses only the gradient test without a positive definite Hessian"
      ),
      code = {
        fit <- .TestFitSmall()
        no_hessian <- fit
        no_hessian@output$hessian <- NULL
        testthat::expect_false(
          object = .MxHelperIsGoodFit(x = no_hessian)
        )
        not_pd <- fit
        not_pd@output$hessian <- -1 * fit$output$hessian
        testthat::expect_false(
          object = .MxHelperIsGoodFit(x = not_pd)
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
        testthat::expect_identical(
          object = MxHelperIsGoodFit(
            x = .TestFitSmall(),
            nd_tol = NULL
          ),
          expected = .MxHelperIsGoodFit(
            x = .TestFitSmall(),
            nd_tol = NULL
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
        testthat::expect_error(
          object = MxHelperIsGoodFit(
            x = .TestFit(),
            nd_tol = -1
          ),
          regexp = "`nd_tol` must be NULL or"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-is-good-fit"
)
