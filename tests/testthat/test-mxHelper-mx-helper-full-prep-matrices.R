## ---- test-mxHelper-mx-helper-full-prep-matrices
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "returns the arguments of mxMatrix()"),
      code = {
        out <- .MxHelperFullPrepMatrices(
          m = 2,
          n = 2,
          free_val = NULL,
          values = NULL,
          lbound_val = NULL,
          ubound_val = NULL,
          vec = TRUE,
          name = "b"
        )
        testthat::expect_named(
          object = out,
          expected = c("free", "values", "labels", "lbound", "ubound", "vec")
        )
        testthat::expect_equal(
          object = out$labels,
          expected = .MxHelperFullLabels(
            m = 2,
            n = 2,
            name = "b",
            sep = "underscore"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperFullPrepMatrices(
            m = 2,
            n = 2,
            free_val = NULL,
            values = NULL,
            lbound_val = NULL,
            ubound_val = NULL,
            vec = TRUE,
            name = "b"
          ),
          expected = .MxHelperFullPrepMatrices(
            m = 2,
            n = 2,
            free_val = NULL,
            values = NULL,
            lbound_val = NULL,
            ubound_val = NULL,
            vec = TRUE,
            name = "b"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperFullPrepMatrices(
            m = 2,
            n = 2,
            free_val = NULL,
            values = NULL,
            lbound_val = NULL,
            ubound_val = NULL,
            vec = "yes",
            name = "b"
          ),
          regexp = "`vec` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-full-prep-matrices"
)
