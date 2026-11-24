## ---- test-mxHelper-mx-helper-inv-ldl
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "rebuilds the matrix from its LDL parts"),
      code = {
        x <- matrix(data = c(2, 0.5, 0.5, 1), nrow = 2)
        ldl <- .MxHelperLDL(x = x)
        testthat::expect_equal(
          object = .MxHelperInvLDL(s_l = ldl$s_l, uc_d = ldl$uc_d),
          expected = x
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version equals the internal version"),
      code = {
        testthat::expect_identical(
          object = MxHelperInvLDL(
            s_l = matrix(data = c(0, 0.25, 0, 0), nrow = 2),
            uc_d = c(1, 0)
          ),
          expected = .MxHelperInvLDL(
            s_l = matrix(data = c(0, 0.25, 0, 0), nrow = 2),
            uc_d = c(1, 0)
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "the exported version rejects a bad argument"),
      code = {
        testthat::expect_error(
          object = MxHelperInvLDL(
            s_l = 1,
            uc_d = c(1, 0)
          ),
          regexp = "`s_l` must be"
        )
      }
    )
  },
  text = "test-mxHelper-mx-helper-inv-ldl"
)
