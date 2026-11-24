## ---- test-mxHelper-mx-helper-sigma-diag-from-ldl-mx-matrix
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the parts, with equal diagonal elements"),
      code = {
        out <- .MxHelperSigmaDiagFromLDLMxMatrix(
          p = 2,
          name = "s",
          column_name = "s_d",
          d_free = TRUE,
          d_values = NULL,
          d_lbound = NA,
          d_ubound = NA,
          d_rows = NULL,
          d_cols = NULL,
          d_equal = TRUE
        )
        testthat::expect_named(
          object = out,
          expected = c("s_d", "s_d_vec", "s", "s_vech", "s_vec")
        )
        testthat::expect_equal(
          object = c(out$s_d$labels),
          expected = c("s_d_eq", "s_d_eq")
        )
        model <- OpenMx::mxRun(
          model = OpenMx::mxModel(model = "m", out),
          silent = TRUE,
          useOptimizer = FALSE
        )
        testthat::expect_equal(
          object = OpenMx::mxEval(expression = s, model = model),
          expected = diag(x = 2),
          tolerance = 1e-6
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSigmaDiagFromLDLMxMatrix(
            p = 2,
            name = "s",
            column_name = "s_d",
            d_free = TRUE,
            d_values = NULL,
            d_lbound = NA,
            d_ubound = NA,
            d_rows = NULL,
            d_cols = NULL,
            d_equal = TRUE
          ),
          expected = .MxHelperSigmaDiagFromLDLMxMatrix(
            p = 2,
            name = "s",
            column_name = "s_d",
            d_free = TRUE,
            d_values = NULL,
            d_lbound = NA,
            d_ubound = NA,
            d_rows = NULL,
            d_cols = NULL,
            d_equal = TRUE
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSigmaDiagFromLDLMxMatrix(
            p = 1.5,
            name = "s",
            column_name = "s_d",
            d_free = TRUE,
            d_values = NULL,
            d_lbound = NA,
            d_ubound = NA,
            d_rows = NULL,
            d_cols = NULL,
            d_equal = TRUE
          ),
          regexp = "`p` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sigma-diag-from-ldl-mx-matrix"
)
