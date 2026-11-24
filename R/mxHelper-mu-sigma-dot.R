#' Fit the Saturated Model (Internal)
#'
#' Fits the saturated model (means and covariances) to the data
#' by full information maximum likelihood, with
#' `OpenMx::mxTryHard()`.
#' The covariance matrix is
#' \eqn{\boldsymbol{L} \boldsymbol{L}^{\prime}}, with \eqn{\boldsymbol{L}}
#' lower triangular and its diagonal bounded below by
#' \eqn{10^{-6}}; its starting value is the Cholesky factor of the
#' pairwise covariance matrix, made positive definite first.
#' No input checks: see [MxHelperMuSigma()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Data frame or numeric matrix.
#'   Observed variables in columns, with column names.
#'   Missing values are allowed (full information ML).
#' @param ... Further arguments to `OpenMx::mxTryHard()`.
#'
#' @return Returns a fitted OpenMx model named `FIML`, with the matrices
#'   `l`, `mu`, and the algebra `sigma`.
#'
#' @examples
#' set.seed(seed = 42)
#' x <- data.frame(
#'   y1 = rnorm(n = 50),
#'   y2 = rnorm(n = 50)
#' )
#' fit <- .MxHelperQuiet(
#'   expr = .MxHelperMuSigma(
#'     x = x,
#'     extraTries = 2
#'   )
#' )
#' OpenMx::mxEval(
#'   expression = sigma,
#'   model = fit
#' )
#'
#' @family Model Fitting Functions
#' @keywords mxHelper internal
#' @noRd
.MxHelperMuSigma <- function(x,
                             ...) {
  x <- as.data.frame(x = x)
  manifests <- names(x = x)
  p <- length(x = manifests)
  start_s <- stats::cov(
    x = x,
    use = "pairwise.complete.obs"
  )
  if (anyNA(x = start_s)) {
    start_s <- diag(x = p)
  }
  start_s <- tryCatch(
    expr = as.matrix(
      x = Matrix::nearPD(
        x = start_s,
        corr = FALSE
      )$mat
    ),
    error = function(e) {
      as.matrix(x = start_s)
    }
  )
  l_start <- tryCatch(
    expr = t(x = chol(x = start_s)),
    error = function(e) {
      ev <- eigen(
        x = start_s,
        symmetric = TRUE
      )
      ev$values[ev$values < 1e-8] <- 1e-8
      s_fix <- ev$vectors %*%
        diag(x = ev$values, nrow = p) %*%
        t(x = ev$vectors)
      t(x = chol(x = s_fix))
    }
  )
  start_m <- colMeans(
    x = x,
    na.rm = TRUE
  )
  lbound_l <- matrix(
    data = NA_real_,
    nrow = p,
    ncol = p
  )
  diag(x = lbound_l) <- 1e-6
  OpenMx::mxTryHard(
    model = OpenMx::mxModel(
      model = "FIML",
      OpenMx::mxData(
        observed = x,
        type = "raw"
      ),
      OpenMx::mxMatrix(
        type = "Lower",
        nrow = p,
        ncol = p,
        free = TRUE,
        values = l_start,
        lbound = lbound_l,
        name = "l",
        dimnames = list(
          manifests,
          manifests
        )
      ),
      OpenMx::mxAlgebraFromString(
        algString = "l %*% t(l)",
        name = "sigma"
      ),
      OpenMx::mxMatrix(
        type = "Full",
        nrow = 1,
        ncol = p,
        free = TRUE,
        values = start_m,
        name = "mu",
        dimnames = list(
          NULL,
          manifests
        )
      ),
      OpenMx::mxExpectationNormal(
        covariance = "sigma",
        means = "mu",
        dimnames = manifests
      ),
      OpenMx::mxFitFunctionML()
    ),
    ...
  )
}
