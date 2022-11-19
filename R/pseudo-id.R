#' Create an ID for a vector
#'
#' Transforms a vector into an integer of IDs.
#'
#' @param x A vector of values
#' @param ... Additional arguments passed to methods
#'
#' @returns A `pseudo_id` object where the `integer` value of the vector
#' correspond to the position of the unique values in the attribute `"values"`.
#'
#' @examples
#' set.seed(42)
#' (x <- sample(letters, 10, TRUE))
#' (pid <- pseudo_id(x))
#' attr(pid, "values")[pid]
#'
#' @export
pseudo_id <- function(x, ...) {
  UseMethod("pseudo_id", x)
}

#' @export
#' @rdname pseudo_id
pseudo_id.pseudo_id <- function(x, ...) {
  x
}

#' @export
#' @rdname pseudo_id
#' @param na_last `Logical` if `FALSE` will not place `NA` at the end
pseudo_id.default <- function(x, na_last = TRUE, ...) {
  ux <- unique(x)
  if (na_last) ux <- na_last(ux)
  new_pseudo_id(vec_match(as.character(x), as.character(ux)), ux)
}

#' @export
#' @rdname pseudo_id
pseudo_id.factor <- function(x, ...) {
  pseudo_id(as_values(fact(x)))
}


# helpers -----------------------------------------------------------------

is_pseudo_id <- function(x) {
  inherits(x, "pseudo_id")
}

is.pseudo_id <- is_pseudo_id

na_last <- function(x) {
  if (anyNA(x)) {
    nas <- is.na(x)
    vec_c(x[!nas], x[nas])
  } else {
    x
  }
}
