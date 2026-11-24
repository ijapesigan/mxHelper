# Shared test helpers (testthat sources helper-*.R before the tests).
# rProject writes this file once; it is yours after that.

# Slow tests: run on CI and on request, skipped in local builds and on CRAN.
.SkipSlow <- function() {
  testthat::skip_on_cran()
  testthat::skip_if_not(
    condition = Sys.getenv(x = "CI") == "true" ||
      Sys.getenv(x = "RPROJECT_SLOW_TESTS") == "true",
    message = "set RPROJECT_SLOW_TESTS=true to run slow tests"
  )
}

# Proprietary software: never on CI or CRAN, and only where it is found.
.SkipIfMissing <- function(program) {
  testthat::skip_on_cran()
  testthat::skip_on_ci()
  testthat::skip_if(
    condition = Sys.which(names = program) == "",
    message = paste0(program, " is not installed")
  )
}

# Data for the fit tests: two correlated variables.
.TestData <- function() {
  set.seed(seed = 42)
  x <- data.frame(
    y1 = stats::rnorm(n = 100),
    y2 = stats::rnorm(n = 100)
  )
  x$y2 <- x$y2 + 0.5 * x$y1
  x
}

# The saturated model of .MxHelperMuSigma(), not fitted.
.TestModel <- function() {
  x <- .TestData()
  manifests <- names(x = x)
  lbound <- matrix(data = NA_real_, nrow = 2, ncol = 2)
  diag(x = lbound) <- 1e-6
  OpenMx::mxModel(
    model = "test",
    OpenMx::mxData(observed = x, type = "raw"),
    OpenMx::mxMatrix(
      type = "Lower",
      nrow = 2,
      ncol = 2,
      free = TRUE,
      values = diag(x = 2),
      lbound = lbound,
      name = "l",
      dimnames = list(manifests, manifests)
    ),
    OpenMx::mxAlgebraFromString(algString = "l %*% t(l)", name = "sigma"),
    OpenMx::mxMatrix(
      type = "Full",
      nrow = 1,
      ncol = 2,
      free = TRUE,
      values = 0,
      name = "mu",
      dimnames = list(NULL, manifests)
    ),
    OpenMx::mxExpectationNormal(
      covariance = "sigma",
      means = "mu",
      dimnames = manifests
    ),
    OpenMx::mxFitFunctionML()
  )
}

# The fitted model, once per test run.
.mxhelper_test <- new.env()
.TestFit <- function() {
  if (is.null(x = .mxhelper_test$fit)) {
    .mxhelper_test$fit <- OpenMx::mxRun(model = .TestModel(), silent = TRUE)
  }
  .mxhelper_test$fit
}

# The fit with the lower bound of test.l[2,1] at its estimate.
.TestAtBound <- function() {
  fit <- .TestFit()
  est <- OpenMx::omxGetParameters(model = fit)
  OpenMx::omxSetParameters(
    model = fit,
    labels = "test.l[2,1]",
    lbound = est[["test.l[2,1]"]]
  )
}
