# fact --------------------------------------------------------------------

fact_ptype <- function(levels) {
  fact(levels)[0]
}

#' Factor
#'
#' Quickly create a factor
#'
#' @details [fact::fact()] can be about 5 times quicker than [base::factor()] or
#'   [base::as.factor()] as it doesn't bother sorting the levels for non-numeric
#'   data or have other checks or features.  It simply converts a vector to a
#'   factor with all unique values as levels with `NA`s included.
#'
#'   [fact::fact.factor()] will perform several checks on a factor to include
#'   `NA` levels and to check if the levels should be reordered to conform with
#'   the other methods.  The [fact::fact.fact()] method simple returns `x`.
#'
#'   By default, `NA` values are sorted as the first value.  This can be
#'   changed by setting `option(fact.na.position = "last")`.
#'
#' @section level orders:
#'
#'   The order of the levels may be adjusted to these rules depending on the
#'   class of `x`:
#' \describe{
#'   \item{`character`}{The order of appearance}
#'   \item{`numeric`/`integer`/`Date`/`POSIXt`}{By the numeric order}
#'   \item{`logical`}{As `FALSE`, `TRUE`}
#'   \item{`factor`}{Numeric if levels can be safely converted, otherwise as
#'   they are}
#' }
#'
#' @param x A vector of values
#' @return A vector of equal length of `x` with class `fact` and `factor`.  If
#'   `x` was `ordered`, that class is added in between.
#'
#' @export
fact <- function(x) {
  UseMethod("fact", x)
}

#' @rdname fact
#' @export
fact.default <- function(x) {
  stop(class_error(x = x, "there is no fact method for this class"))
}

#' @rdname fact
#' @export
fact.logical <- function(x) {
  x <- as.integer(x)
  if (anyNA(x)) {
    if (move_na_last()) {
      u <- c(FALSE, TRUE, NA)
      x <- x + 1L
      x[is.na(x)] <- 1L
    } else {
      u <- c(NA, FALSE, TRUE)
      x <- x + 2L
      x[is.na(x)] <- 1L
    }
  } else {
    x <- x + 1L
    u <- c(FALSE, TRUE)
  }
  new_fact(x, as.character(u), logical())
}

#' @rdname fact
#' @export
fact.character <- function(x) {
  u <- unique(x)
  if (anyNA(u)) {
    m <- vec_match(NA, u)
    if (move_na_last()) {
      u <- c(u[-m], NA)
    } else {
      u <- c(NA, u[-m])
    }
  }
  new_fact(vec_match(x, u), u, character())
}

#' @rdname fact
#' @export
fact.numeric <- function(x) {
  u <- vec_sort(
    vec_unique(x),
    na_value = if (move_na_last()) "largest" else "smallest"
  )
  # l <- as.character(u)
  # d <- !vec_duplicate_detect(l)
  # u <- u[d]
  # l <- l[d]
  # new_fact(vec_match(x, u), l, vec_ptype(x))
  new_fact(vec_match(x, u), as.character(u), vec_ptype(x))
}

#' @rdname fact
#' @export
fact.integer <- fact.numeric

#' @rdname fact
#' @export
fact.complex <- fact.numeric

#' @rdname fact
#' @export
fact.Date <- fact.numeric

#' @rdname fact
#' @export
fact.POSIXct <- fact.numeric

#' @rdname fact
#' @export
fact.POSIXlt <- fact.numeric

#' @rdname fact
#' @export
fact.factor <- function(x) {
  converted <- utils::type.convert(levels(x), as.is = TRUE, tryLogical = TRUE)
  if (is.character(converted)) {
    maybe <- as.POSIXlt(x, optional = TRUE)
    if (!all(is.na(maybe))) {
      converted <- maybe
    }
  }

  fact(converted[x])
}

#' @rdname fact
#' @export
fact.fact <- function(x) {
  x
}

# helpers -----------------------------------------------------------------

new_fact <- function(x = integer(), levels = character(), ptype = character()) {
  levels(x) <- as.character(levels)
  attr(x, "ptype") <- ptype
  class(x) <- c("fact", "factor")
  x
}

move_na_last <- function() {
  switch(
    match_arg(
      getOption("mark.fact.na.position"),
      c("first", "last"),
      null = "first"
    ),
    first = FALSE,
    last = TRUE,
    stop("somthing went wrong") # nocov
  )
}
