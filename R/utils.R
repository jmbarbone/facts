#' @export
#' @name fact
values <- function(x) {
  get_values(x)
}

get_values <- function(x, fun = identity) {
  if (!is_fact(x)) {
    stop(class_error("values() only works with fact objects"))
  }
  fun(.values(x))[x]
}

.values <- function(x) {
  cast(levels(x), exattr(x, "ptype"))
}

#' @export
#' @name fact
is_fact <- function(x) {
  inherits(x, "fact")
}

#' @export
#' @name fact
is.fact <- is_fact # nolint: object_name_linter.
