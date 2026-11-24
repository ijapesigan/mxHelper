## ---- test-mxHelper-mx-helper-full-fixed
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds a matrix with no free elements"),
      code = {
        out <- .MxHelperFullFixed(
          m = 2,
          n = 2,
          values = NULL,
          row = NULL,
          col = NULL,
          name = "z"
        )
        testthat::expect_named(
          object = out,
          expected = "z"
        )
        testthat::expect_false(
          object = any(out$z$free)
        )
        testthat::expect_equal(
          object = unname(obj = out$z$values),
          expected = matrix(data = 0, nrow = 2, ncol = 2)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperFullFixed(
            m = 2,
            n = 2,
            values = diag(x = 2),
            row = NULL,
            col = NULL,
            name = "z"
          ),
          expected = .MxHelperFullFixed(
            m = 2,
            n = 2,
            values = diag(x = 2),
            row = NULL,
            col = NULL,
            name = "z"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperFullFixed(
            m = 0,
            n = 2,
            values = NULL,
            row = NULL,
            col = NULL,
            name = "z"
          ),
          regexp = "`m` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-full-fixed"
)
