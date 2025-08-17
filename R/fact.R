
#' Factor
#'
#' Quickly create a factor
#'
#' @details `fact()` can be about 5 times quicker than `factor()` or
#'   `as.factor()` as it doesn't bother sorting the levels for non-numeric data
#'   or have other checks or features.  It simply converts a vector to a factor
#'   with all unique values as levels with `NA`s included.
#'
#'   `fact.factor()` will perform several checks on a factor to include `NA`
#'   levels and to check if the levels should be reordered to conform with the
#'   other methods.  The `fact.fact()` method simple returns `x`.
#'
#' @section level orders:
#'
#' The order of the levels may be adjusted to these rules depending on the class
#' of `x`:
#' \describe{
#'   \item{`character`}{The order of appearance}
#'   \item{`numeric`/`integer`/`Date`/`POSIXt`}{By the numeric order}
#'   \item{`logical`}{As `TRUE`, `FALSE`, then `NA` if present}
#'   \item{`factor`}{Numeric if levels can be safely converted, otherwise as
#'   they are}
#' }
#'
#' @param x A vector of values
#' @param ... Additional arguments passed to methods
#' @return A vector of equal length of `x` with class `fact` and `factor`.  If
#'   `x` was `ordered`, that class is added in between.
#'
#' @seealso [as_ordered()]
#' @family factors
#' @export
fact <- function(x, ...) {
  UseMethod("fact", x)
}

#' @rdname fact
#' @export
fact.default <- function(x, ...) {
  stop(fact_method_condition(x))
}

#' @rdname fact
#' @param levels Optional specification of levels for `x`.  When `NULL`, will
#'   default to all the unique values of `x` in the order they appear.
#'   Duplicated values are silently dropped.
#' @export
fact.character <- function(x, levels = NULL, ...) {
  out <- pseudo_id(x)
  new_fact(
    out,
    values = values(out),
    levels = if (!is.null(levels)) vec_unique(levels)
  )
}

#' @rdname fact
#' @export
fact.numeric <- function(x, ...) {
  if (isTRUE(getOption("facts.guess.integer", FALSE)) && is_integerish(x)) {
    old <- class(x) %wo% c("double", "numeric")
    x <- as.integer(x)
    x <- add_class(x, old)
    return(fact(x, ...))
  }

  # Don't bother NaN
  # x[is.nan(x)] <- NA
  u <- vec_sort(vec_unique(x))
  new_fact(vec_match(x, u), u)
}

#' @rdname fact
#' @param range Controls setting of additional labels.  Accepts a numeric vector
#'   that can be safely coerced to an `integer`.  A sequence of `integers` is
#'   reconstructed from `range` and used as all the `fact` levels.  All `NA` and
#'   `Inf` values are dropped.  At least one non-missing and finite value must
#'   be present.
#' @export
fact.integer <- function(x, range = NULL, ...) {
  u <- vec_sort(vec_unique(x))

  if (!is.null(range)) {
    range <- range_safe(range, x)
  }

  new_fact(
    vec_match(x, u),
    values = u,
    levels = range,
    range = range2(range)
  )
}

range2 <- function(x) {
  if (is.null(x)) return(NULL)
  c(min(x, na.rm = TRUE), max(x, na.rm = TRUE))
}

range_safe <- function(x, y) {
  if (is.numeric(y)) {
    date <- FALSE
    if (!is.numeric(x)) {
      stop(fact_range_numeric_condition())
    }
  } else if (inherits(y, "Date")) {
    date <- TRUE
    if (!inherits(x, "Date")) {
      stop(fact_range_date_condition())
    }
  } else {
    stop(fact_range_types_condition())
  }

  x <- x[is.finite(x) & !is.na(x)]
  if (!length(x)) {
    stop(fact_range_finite_condition())
  }

  res <- seq.int(min(x), max(x), by = 1L)

  if (date) {
    res <- as.Date(res, origin = "1950-01-01")
  } else {
    res <- as.integer(res)
  }

  res
}

#' @rdname fact
#' @export
fact.Date <- fact.integer

#' @rdname fact
#' @export
fact.POSIXt <- fact.numeric

#' @rdname fact
#' @export
fact.logical <- function(x, ...) {
  out <- as.integer(x) + 1L
  na <- anyNA(x)

  if (na) {
    out[is.na(x)] <- 3L
  }

  new_fact(
    out,
    values = c(FALSE, TRUE, if (na) NA),
    na = if (na) 3L else 0L
  )
}

#' @rdname fact
#' @export
fact.factor <- function(x, ...) {
  lvls <- levels(x)

  if (!anyNA(lvls) && anyNA(x)) {
    lvls <- c(lvls, NA_character_)
  }

  lvls <- na_last(lvls)
  m <- vec_match(lvls, lvls)[x]
  new_fact(m, lvls, ordered = is.ordered(x))
}

#' @rdname fact
#' @export
fact.fact <- function(x, ...) {
  x
}

#' @rdname fact
#' @export
fact.pseudo_id <- function(x, ...) {
  u <- values(x)

  # check if numeric and already ordered
  if (is.numeric(u)) {
    o <- vec_order(u)
    if (!identical(o, u)) {
      x <- vec_match(u[o], u)[x]
      u <- u[o]
    }
  }

  new_fact(x, u)
}
