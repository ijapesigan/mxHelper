## ---- test-mxHelper-mx-helper-sigma-from-ldl-log-algebra
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "evaluates to L D L' with the log of the column"),
      code = {
        model <- OpenMx::mxModel(
          model = "m",
          OpenMx::mxMatrix(
            type = "Lower",
            nrow = 2,
            ncol = 2,
            values = c(0, 0.25, 0),
            name = "s_l"
          ),
          OpenMx::mxMatrix(
            type = "Full",
            nrow = 2,
            ncol = 1,
            values = c(exp(x = 2), exp(x = 0.875)),
            name = "s_d"
          ),
          OpenMx::mxMatrix(type = "Iden", nrow = 2, ncol = 2, name = "s_i"),
          .MxHelperSigmaFromLDLLogAlgebra(
            sdiag = "s_l",
            column = "s_d",
            iden = "s_i",
            name = "s"
          )
        )
        model <- OpenMx::mxRun(
          model = model,
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
        testthat::expect_identical(
          object = MxHelperSigmaFromLDLLogAlgebra(
            sdiag = "s_l",
            column = "s_d",
            iden = "s_i",
            name = "s"
          ),
          expected = .MxHelperSigmaFromLDLLogAlgebra(
            sdiag = "s_l",
            column = "s_d",
            iden = "s_i",
            name = "s"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSigmaFromLDLLogAlgebra(
            sdiag = "s_l",
            column = "s_d",
            iden = "s_i",
            name = NA
          ),
          regexp = "`name` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-sigma-from-ldl-log-algebra"
)
