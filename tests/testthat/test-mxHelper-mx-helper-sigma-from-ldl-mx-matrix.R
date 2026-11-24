## ---- test-mxHelper-mx-helper-sigma-from-ldl-mx-matrix
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds the parts and evaluates to the matrix"),
      code = {
        ldl <- .MxHelperLDL(x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2))
        out <- .MxHelperSigmaFromLDLMxMatrix(
          p = 2,
          name = "s",
          column_name = "s_d",
          sdiag_name = "s_l",
          iden_name = NULL,
          d_free = TRUE,
          d_values = ldl$uc_d,
          d_lbound = NA,
          d_ubound = NA,
          d_rows = NULL,
          d_cols = NULL,
          d_equal = FALSE,
          l_free = TRUE,
          l_values = ldl$s_l,
          l_lbound = NA,
          l_ubound = NA,
          l_rows = NULL,
          l_cols = NULL
        )
        testthat::expect_named(
          object = out,
          expected = c(
            "s_l", "s_l_vec", "s_d", "s_d_vec", "s_iden", "s", "s_vech",
            "s_vec"
          )
        )
        model <- OpenMx::mxRun(
          model = OpenMx::mxModel(model = "m", out),
          silent = TRUE,
          useOptimizer = FALSE
        )
        testthat::expect_equal(
          object = OpenMx::mxEval(expression = s, model = model),
          expected = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2),
          tolerance = 1e-6
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        ldl <- .MxHelperLDL(x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2))
        testthat::expect_identical(
          object = MxHelperSigmaFromLDLMxMatrix(
            p = 2,
            name = "s",
            column_name = "s_d",
            sdiag_name = "s_l",
            iden_name = NULL,
            d_free = TRUE,
            d_values = ldl$uc_d,
            d_lbound = NA,
            d_ubound = NA,
            d_rows = NULL,
            d_cols = NULL,
            d_equal = FALSE,
            l_free = TRUE,
            l_values = ldl$s_l,
            l_lbound = NA,
            l_ubound = NA,
            l_rows = NULL,
            l_cols = NULL
          ),
          expected = .MxHelperSigmaFromLDLMxMatrix(
            p = 2,
            name = "s",
            column_name = "s_d",
            sdiag_name = "s_l",
            iden_name = NULL,
            d_free = TRUE,
            d_values = ldl$uc_d,
            d_lbound = NA,
            d_ubound = NA,
            d_rows = NULL,
            d_cols = NULL,
            d_equal = FALSE,
            l_free = TRUE,
            l_values = ldl$s_l,
            l_lbound = NA,
            l_ubound = NA,
            l_rows = NULL,
            l_cols = NULL
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        ldl <- .MxHelperLDL(x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2))
        testthat::expect_error(
          object = MxHelperSigmaFromLDLMxMatrix(
            p = 2,
            name = "s",
            column_name = "s_d",
            sdiag_name = "s_l",
            iden_name = NULL,
            d_free = TRUE,
            d_values = ldl$uc_d,
            d_lbound = NA,
            d_ubound = NA,
            d_rows = NULL,
            d_cols = NULL,
            d_equal = NA,
            l_free = TRUE,
            l_values = ldl$s_l,
            l_lbound = NA,
            l_ubound = NA,
            l_rows = NULL,
            l_cols = NULL
          ),
          regexp = "`d_equal` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sigma-from-ldl-mx-matrix"
)
