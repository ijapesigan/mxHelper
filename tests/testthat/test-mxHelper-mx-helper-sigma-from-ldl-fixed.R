## ---- test-mxHelper-mx-helper-sigma-from-ldl-fixed
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "builds a fixed matrix that evaluates to the input"),
      code = {
        ldl <- .MxHelperLDL(x = matrix(data = c(2, 0.5, 0.5, 1), nrow = 2))
        out <- .MxHelperSigmaFromLDLFixed(
          p = 2,
          d_values = ldl$uc_d,
          l_values = ldl$s_l,
          row = c("y1", "y2"),
          name = "s",
          iden_name = NULL
        )
        testthat::expect_false(
          object = any(out$s_l$free, out$s_d$free)
        )
        model <- OpenMx::mxRun(
          model = OpenMx::mxModel(
            model = "m",
            out,
            OpenMx::mxMatrix(
              type = "Iden",
              nrow = 2,
              ncol = 2,
              name = "s_iden"
            )
          ),
          silent = TRUE,
          useOptimizer = FALSE
        )
        testthat::expect_equal(
          object = unname(
            obj = OpenMx::mxEval(expression = s, model = model)
          ),
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
          object = MxHelperSigmaFromLDLFixed(
            p = 2,
            d_values = ldl$uc_d,
            l_values = ldl$s_l,
            row = NULL,
            name = "s",
            iden_name = NULL
          ),
          expected = .MxHelperSigmaFromLDLFixed(
            p = 2,
            d_values = ldl$uc_d,
            l_values = ldl$s_l,
            row = NULL,
            name = "s",
            iden_name = NULL
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSigmaFromLDLFixed(
            p = 2,
            d_values = NULL,
            l_values = diag(x = 2),
            row = NULL,
            name = "s",
            iden_name = NULL
          ),
          regexp = "`d_values` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sigma-from-ldl-fixed"
)
