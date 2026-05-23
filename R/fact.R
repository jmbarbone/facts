# fact --------------------------------------------------------------------

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
  if (move_na_last()) {
    u <- c(FALSE, TRUE, if (anyNA(x)) NA)
  } else {
    u <- c(if (anyNA(x)) NA, FALSE, TRUE)
  }
  new_fact(as.integer(x) + 1L, u, logical())
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
  fact_numeric(x)
}

#' @rdname fact
#' @export
fact.integer <- function(x) {
  fact_numeric(x)
}

#' @rdname fact
#' @export
fact.complex <- function(x) {
  fact_numeric(x)
}

#' @rdname fact
#' @export
fact.Date <- function(x) {
  fact_numeric(x)
}

#' @rdname fact
#' @export
fact.POSIXct <- function(x) {
  fact_numeric(x)
}

#' @rdname fact
#' @export
fact.POSIXlt <- function(x) {
  fact_numeric(x)
}

#' @rdname fact
#' @export
fact.factor <- function(x) {
  old <- levels(x)
  old <- utils::type.convert(old, as.is = TRUE, tryLogical = FALSE)
  if (is.character(old)) {
    maybe <- as.POSIXlt(x, optional = TRUE)
    if (!all(is.na(maybe))) {
      old <- maybe
    }
  }

  new <- vec_order(o, na_value = if (move_na_last()) "largest" else "smallest")
  x <- vec_match(old, new)[x]
  for (c in class(old)) {
    fun <- get0(sprintf("as.%s", c))
    if (!is.null(fun)) {
      break
    }
  }
  new_fact(x, new, fun %||% identity)
}

#' @rdname fact
#' @export
fact.fact <- function(x) {
  x
}

# helpers -----------------------------------------------------------------

new_fact <- function(x, levels, ptype) {
  levels(x) <- as.character(levels)
  attr(x, "ptype") <- ptype
  # assign "factor" class _after_ levels()
  class(x) <- c("fact", "factor")
  x
}

fact_numeric <- function(x) {
  p <- vec_ptype(x)
  u <- vec_unique(x)
  u <- vec_sort(u, na_value = if (move_na_last()) "largest" else "smallest")
  l <- as.character(u)
  d <- !vec_duplicate_detect(l)
  u <- u[d]
  l <- l[d]
  new_fact(vec_match(x, u), l, p)
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

# other methods -----------------------------------------------------------

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
    x <- as.integer(x)
    x[x == m] <- NA_integer_
    x <- x - (x > m)
    levels(x) <- lev[-m]
  }
  class(x) <- c("ordered", "fact", "factor")
  x
}

#' @export
as.factor.fact <- identity
