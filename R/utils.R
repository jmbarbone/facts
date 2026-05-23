#' @export
#' @name fact
values <- function(x) {
  get_values(x)
}

get_values <- function(x, fun = identity) {
  fun(cast(levels(x), exattr(x, "ptype")))[x]
}

#' @export
#' @name fact
is_fact <- function(x) {
  inherits(x, "fact")
}

#' @export
#' @name fact
is.fact <- is_fact # nolint: object_name_linter.
