## ---- test-mxHelper-mx-helper-sdiag-mx-matrix
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the matrix and the vector of free elements"),
      code = {
        out <- .MxHelperSdiagMxMatrix(
          p = 2,
          free_val = NULL,
          values = NULL,
          lbound_val = NULL,
          ubound_val = NULL,
          vec = TRUE,
          row = NULL,
          col = NULL,
          name = "b"
        )
        testthat::expect_named(
          object = out,
          expected = c("b", "b_vec")
        )
        testthat::expect_s4_class(
          object = out$b,
          class = "MxMatrix"
        )
        testthat::expect_equal(
          object = c(out$b_vec$labels),
          expected = "b[2,1]"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSdiagMxMatrix(
            p = 2,
            free_val = NULL,
            values = NULL,
            lbound_val = NULL,
            ubound_val = NULL,
            vec = TRUE,
            row = NULL,
            col = NULL,
            name = "b"
          ),
          expected = .MxHelperSdiagMxMatrix(
            p = 2,
            free_val = NULL,
            values = NULL,
            lbound_val = NULL,
            ubound_val = NULL,
            vec = TRUE,
            row = NULL,
            col = NULL,
            name = "b"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSdiagMxMatrix(
            p = 2,
            free_val = NULL,
            values = NULL,
            lbound_val = NULL,
            ubound_val = NULL,
            vec = TRUE,
            row = 1,
            col = NULL,
            name = "b"
          ),
          regexp = "`row` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sdiag-mx-matrix"
)
