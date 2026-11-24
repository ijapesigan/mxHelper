#' Status Code of a Fitted Model (Internal)
#'
#' Reads the OpenMx status code of a fitted model.
#' Stops with an error when the model has no single status code,
#' and warns, with the status details, when the code is not 0.
#' No input checks: see [MxHelperStatusCode()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param model An OpenMx model (`MxModel`).
#' @param context Character string.
#'   Name of the model in the messages.
#'   By default, the expression passed as `model`.
#'
#' @return Returns the status code; the internal version returns it
#'   invisibly.
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
#' .CheckStatusCode(
#'   model = fit
#' )
#'
#' @family Fit Diagnostics Functions
#' @keywords mxHelper internal
#' @noRd
.CheckStatusCode <- function(model,
                             context = deparse(
                               expr = substitute(expr = model)
                             )) {
  .Check <- function(x, msg) {
    if (is.null(x = x)) {
      stop(msg, call. = FALSE)
    } else {
      x
    }
  }
  code <- .Check(
    tryCatch(
      expr = model@output$status$code,
      error = function(e) {
        NULL
      }
    ),
    sprintf(
      fmt = paste(
        "No OpenMx status code found in `%s`",
        "(expected `model@output$status$code`)."
      ),
      context
    )
  )
  if (!is.numeric(x = code) || length(x = code) != 1L || is.na(x = code)) {
    stop(
      sprintf(
        fmt = "Status code in `%s` is not a single non-NA numeric value.",
        context
      ),
      call. = FALSE
    )
  }
  if (code != 0) {
    msg <- tryCatch(
      expr = model@output$status$details,
      error = function(e) {
        NULL
      }
    )
    if (is.null(x = msg) || !nzchar(x = msg)) {
      msg <- "No status details provided."
    }
    warning(
      sprintf(
        fmt = "OpenMx returned status code %s for `%s`: %s",
        code,
        context,
        msg
      ),
      call. = FALSE
    )
  }
  invisible(x = code)
}
