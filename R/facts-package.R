#' @import fuj
#' @import vctrs
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

# nolint next: object_name_linter.
op.facts <- list0(
  facts.bool.integer = FALSE,
  facts.factor.convert = FALSE,
  facts.guess.integer = FALSE,
  facts.na.value = "(na)",
)

.onLoad <- function(libname, pkgname) {
  # nolint next: undesirable_function_linter.
  options(op.facts[names(op.facts) %out% names(options())])
}

.force_namespaces <- function() {
  cnd::cnd # maybe I'll use it
}
