#' @importFrom generics as.ordered
#' @export
generics::as.ordered

#' @importFrom generics as.factor
#' @export
generics::as.factor

#' @export
as.ordered.fact <- function(x) {
  if (is.ordered(x)) {
    return(x)
  }

  x <- fact(x)
  lev <- levels(x)
  if (anyNA(levels(x))) {
    # NA values just need to be shifted
    m <- which(is.na(lev))
    x <- unclass(x)
    x[x == m] <- NA_integer_
    x <- x - (x > m)
    levels(x) <- lev[-m]
  }
  class(x) <- c("ordered", "fact", "factor")
  x
}

#' @export
as.integer.fact <- function(x) {
  # this might not be needed after it's removed from {mark}
  class(x) <- "integer"
  attr(x, "levels") <- NULL
  attr(x, "ptype") <- NULL
  x
}

#' @export
as.factor.fact <- identity

#' @export
levels.fact <- function(x) {
  exattr(x, "levels")
}

#' @export
droplevels <- function(x, ...) {
  fact(values(x))
}

#' @export
`[.fact` <- function(x, i, ...) {
  out <- unclass(x)[i]
  levels(out) <- levels(x)
  class(out) <- oldClass(x)
  attr(out, "ptype") <- exattr(x, "ptype")
  out
}

#' @export
`[[.fact` <- function(x, i, ...) {
  NextMethod(x)
}

#' @export
unique.fact <- function(x, incomparables = FALSE, ...) {
  if (isTRUE(incomparables)) {
    stop(input_error(
      "`incomparables = TRUE` is not supported for `fact` objects"
    ))
  }

  x[vec_sort(vec_match(.values(x), x))]
}
