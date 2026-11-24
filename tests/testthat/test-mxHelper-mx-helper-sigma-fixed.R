## ---- test-mxHelper-mx-helper-sigma-fixed
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "the identity type evaluates to the identity"),
      code = {
        out <- .MxHelperSigmaFixed(
          p = 2,
          values = NULL,
          row = c("y1", "y2"),
          name = "s",
          iden_name = NULL,
          type = "identity"
        )
        testthat::expect_named(
          object = out,
          expected = c("s_l", "s_d", "s", "s_vech")
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
          expected = diag(x = 2),
          tolerance = 1e-6
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperSigmaFixed(
            p = 2,
            values = NULL,
            row = NULL,
            name = "s",
            iden_name = NULL,
            type = "identity"
          ),
          expected = .MxHelperSigmaFixed(
            p = 2,
            values = NULL,
            row = NULL,
            name = "s",
            iden_name = NULL,
            type = "identity"
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperSigmaFixed(
            p = 2,
            values = NULL,
            row = NULL,
            name = "s",
            iden_name = NULL,
            type = "unit"
          ),
          regexp = "`type` must be"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "a covariance matrix in values evaluates to values"),
      code = {
        sigma <- matrix(
          data = c(2, 0.5, 0.5, 1),
          nrow = 2
        )
        model <- OpenMx::mxRun(
          model = OpenMx::mxModel(
            model = "m",
            .MxHelperSigmaFixed(
              p = 2,
              values = sigma,
              row = c("y1", "y2"),
              name = "s",
              iden_name = NULL,
              type = NULL
            ),
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
          expected = sigma,
          tolerance = 1e-8
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the zero and diffused types scale the identity"),
      code = {
        for (type in c("zero", "diffused")) {
          # the algebra adds 1e-8 to the diagonal of D
          scalar <- switch(
            EXPR = type,
            zero = 1e-10 + 1e-8,
            diffused = 1e10 + 1e-8
          )
          model <- OpenMx::mxRun(
            model = OpenMx::mxModel(
              model = "m",
              .MxHelperSigmaFixed(
                p = 2,
                values = NULL,
                row = c("y1", "y2"),
                name = "s",
                iden_name = NULL,
                type = type
              ),
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
            ) / scalar,
            expected = diag(x = 2),
            tolerance = 1e-6
          )
        }
      }
    )
  },
  text = "test-mxHelper-mx-helper-sigma-fixed"
)
