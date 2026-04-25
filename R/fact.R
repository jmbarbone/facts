#' @importFrom cnd value_error, class_error
#' @importFrom fuj match_arg, struct, exattr

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
fact.character <- function(x) {
  u <- unique(x)
  if (anyNA(u)) {
    m <- match(NA, u)
    if (move_na_last()) {
      u <- c(u[-m], NA)
    } else {
      u <- c(NA, u[-m])
    }
  }
  new_fact(match(x, u), u, identity)
}

#' @rdname fact
#' @export
fact.numeric <- function(x) {
  fact_numeric(x, as.numeric)
}

#' @rdname fact
#' @export
fact.integer <- function(x) {
  fact_numeric(x, as.integer)
}

#' @rdname fact
#' @export
fact.Date <- function(x) {
  fact_numeric(x, as.Date)
}

#' @rdname fact
#' @export
fact.POSIXct <- function(x) {
  fact_numeric(x, as.POSIXct)
}

#' @rdname fact
#' @export
fact.POSIXlt <- function(x) {
  fact_numeric(x, as.POSIXlt)
}

#' @rdname fact
#' @export
fact.logical <- function(x) {
  u <- if (move_na_last()) c(FALSE, TRUE, NA) else c(NA, FALSE, TRUE)
  u <- u[u %in% x]
  new_fact(match(x, u), u, as.logical)
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
  o <- order(old, na.last = move_na_last())
  new <- old[o]
  x <- match(old, new)[x]
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

# others ------------------------------------------------------------------

#' @export
#' @name fact
as_values <- function(x) {
  values(x)[x]
}

#' @export
#' @name fact
as.values <- as_values # nolint: object_name_linter.

#' @export
#' @name fact
values <- function(x) {
  converter(x)(levels(x))
}

#' @export
#' @name fact
converter <- function(x) {
  exattr(x, "converter")
}

#' @export
#' @name fact
`converter<-` <- function(x, value) {
  attr(x, "converter") <- match.fun(value)
}

#' @export
#' @name fact
is_fact <- function(x) {
  inherits(x, "fact")
}

#' @export
#' @name fact
is.fact <- is_fact # nolint: object_name_linter.

# helpers -----------------------------------------------------------------

new_fact <- function(x, levels, fun) {
  levels(x) <- as.character(levels)
  converter(x) <- fun
  # assign "factor" class _after_ levels()
  class(x) <- c("fact", "factor")
  x
}

fact_numeric <- function(x, converter) {
  u <- unique(x)
  u <- u[order(u, method = "radix", na.last = move_na_last())]
  l <- as.character(u)
  d <- !duplicated(l)
  u <- u[d]
  l <- l[d]
  new_fact(match(x, u), l, converter)
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
    stop(value_error(
      "options(fact.na.position) must be 'first' or 'last'"
    ))
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
as.ordered.fact <- function(x, ...) {
  if (is.ordered(x)) {
    return(x)
  }
  v <- values(x)
  class(x) <- c("ordered", class(x))
  values(x) <- v
  x
}

#' @export
as.factor.fact <- function(x, ...) {
  struct(x, c(if (is.ordered(x)) "ordered", "factor"), levels = levels(x))
}
