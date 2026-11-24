## ---- test-mxHelper-input-check
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    testthat::test_that(
      desc = paste(text, "accepts the path of an existing file"),
      code = {
        testthat::expect_invisible(
          call = .CheckInput(x = tempdir())
        )
        testthat::expect_null(
          object = .CheckInput(x = tempdir())
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "rejects a missing file, NA, and non-character input"),
      code = {
        testthat::expect_error(
          object = .CheckInput(x = file.path(tempdir(), "missing-file.rds")),
          regexp = "existing file"
        )
        testthat::expect_error(
          object = .CheckInput(x = NA_character_),
          regexp = "existing file"
        )
        testthat::expect_error(
          object = .CheckInput(x = 1),
          regexp = "existing file"
        )
        testthat::expect_error(
          object = .CheckInput(x = c("a", "b")),
          regexp = "existing file"
        )
      }
    )
  },
  text = "test-mxHelper-input-check"
)
