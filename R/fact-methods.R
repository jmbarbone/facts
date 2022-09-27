
#' @export
as.integer.facts <- function(x, ...) {
  x <- fact_na(x)
  nas <- is.na(x)
  attributes(x) <- NULL
  class(x) <- "integer"
  x[nas] <- NA_integer_
  x
}

#' @export
as.double.facts <- function(x, ...) {
  as.double(as.integer(x))
}

#' @export
as.character.facts <- function(x, ...) {
  as.character(as_values(x))
}

# because unique.factor() remakes factor
# this won't drop levels
#' @export
unique.facts <- function(x, incomparables = FALSE, ...) {
  att <- attributes(x)
  mark::struct(
    unique(unclass(x)),
    class = att$class,
    levels = att$levels,
    values = att$values,
    na = att$na
  )
}

#' @export
as.Date.facts <- function(x, ...) {
  as.Date(as_values(x), ...)[x]
}

#' @export
`[.facts` <- function(x, ...)  {
  y <- NextMethod("[")
  attributes(y) <- attributes(x)
  y
}
