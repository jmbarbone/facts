#' @import vctrs
#' @import fuj
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

op.facts <- list0(
  facts.bool.integer = FALSE,
  facts.factor.convert = FALSE,
  facts.guess.integer = FALSE,
  facts.na.value = "(na)",
)

.onAttach <- function(libname, pkgname) {
  options(op.facts[names(op.facts) %out% names(options())])
}
