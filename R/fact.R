
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
  stop(
    "No fact method for class(es) ",
    collapse(class(x), sep = ", "),
    call. = FALSE
  )
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
  if (isTRUE(getOption("facts.guess.integer", FALSE))) {
    if (is_integerish(x)) {
      return(fact(as.integer(x), ...))
    }
  }

  # Don't bother NaN
  x[is.nan(x)] <- NA
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
  new_fact(
    vec_match(x, u),
    values = u,
    levels = if (!is.null(range)) range_safe(range, x)
  )
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


  x <- as.integer(x)
  x <- x[!is.na(x)]
  if (!length(x)) {
    stop(fact_range_missing_condition())
  }

  x <- x[is.finite(x)]
  if (!length(x)) {
    stop(fact_range_finite_condition())
  }

  res <- seq.int(min(x), max(x))

  if (date) {
    res <- as.Date(res, origin = "1950-01-01")
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
  out <- as.integer(x)
  w <- which(!x)
  out[w] <- out[w] + 2L
  nas <- is.na(x)
  out[nas] <- 3L

  new_fact(
    out,
    values = c(TRUE, FALSE, if (any(nas)) NA),
    na = if (any(nas)) 3L else 0L
  )
}

#' @rdname fact
#' @param convert When `TRUE` tries to convert levels to a more suitable value.
#'   When passed a `function`, will attempt to use that as the conversion
#'   method.  Otherwise, `levels` remain as `character`.
#' @export
fact.factor <- function(x, convert = getOption("facts.factor.convert"), ...) {
  old_levels <- levels(x)

  if (isTRUE(convert)) {
    new_levels <- fact_coerce_levels(old_levels)
    # new_levels <- type_convert2(old_levels)

    if (is.logical(new_levels)) {
      m <- vec_match(new_levels[x], c(TRUE, FALSE, NA))
      res <- new_fact(m, c(TRUE, FALSE, if (anyNA(new_levels[x])) NA))
      return(res)
    }

    if (is.numeric(new_levels) | inherits(x, c("Date", "POSIXt"))) {
      ord_levels <- vec_sort(new_levels)
      o <- vec_match(old_levels, as.character(ord_levels))

      levels <- vec_c(ord_levels, if (anyNA(x) && !anyNA(ord_levels)) NA)

      if (identical(o, seq_along(o))) {
        res <- new_fact(x, levels, ordered = is.ordered(x))
        return(res)
      }

      m <- vec_match(vec_order(old_levels), o)[x]
      res <- new_fact(m, levels, ordered = is.ordered(x))
      return(res)
    }

    if (anyNA(x) || anyNA(old_levels)) {
      new_levels <-
        if (!anyNA(new_levels)) {
          c(new_levels, NA)
        } else {
          na_last(new_levels)
        }
    }
  } else if (is.function(convert)) {
    new_levels <- convert(old_levels)
  } else {
    new_levels <- old_levels
  }

  m <- vec_match(old_levels, as.character(new_levels))[x]
  new_fact(m, new_levels, ordered = is.ordered(x))
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

#' @rdname fact
#' @export
fact.haven_labelled <- function(x, ...) {
  lvls <- attr(x, "labels")

  if (length(lvls)) {
    ux <- unclass(x)
    vals <- sort.int(unique(c(ux, lvls)))
    m <- vec_match(ux, vals)
    ml <- vec_match(lvls, vals)
    vals[ml] <- names(lvls)
    res <- new_fact(m, vals)
  } else {
    res <- fact(unclass(x))
  }

  attr(res, "label") <- exattr(x, "label")
  res
}

#' @export
print.fact <- function(
    x,
    max_levels = getOption("facts.max_levels", TRUE),
    width = getOption("width"),
    ...
) {
  # mostly a reformatted base::print.factor()
  # TODO check for `range` attribute and print something a bit nicer
  ord <- is.ordered(x)
  if (length(x) == 0L) {
    cat(if (ord) "ordered" else "factor", "(0)\n", sep = "")
  } else {
    print(as.character(x), quote = FALSE, ...)
  }

  if (max_levels) {
    lev <- encodeString(levels(x), quote = "")
    n <- length(lev)
    colsep <- if (ord) " < " else " "

    if (length(range <- exattr(x, "range")) == 2L) {
      lab <- cat(
        "range: ", range[1L], " to ", range[2L],
        if (na <- exattr(x, "na")) c(", ", levels(x)[na]),
        "\n",
        sep = ""
      )
    } else {
      T0 <- "levels: "
      if (is.logical(max_levels)) {
        max_levels <- {
          width <- width - (nchar(T0, "w") + 3L +  1L + 3L)
          lenl <- cumsum(nchar(lev, "w") + nchar(colsep, "w"))

          if (n <= 1L || lenl[n] <= width) {
            n
          } else {
            max(1L, which.max(lenl > width) - 1L)
          }
        }
      }
      drop <- n > max_levels
      cat(
        if (drop) paste(format(n), ""),
        T0,
        paste(
          if (drop) {
            c(lev[1L:max(1, max_levels - 1)], "...", if (max_levels >  1) lev[n])
          } else {
            lev
          },
          collapse = colsep
        ),
        "\n",
        sep = ""
      )
    }

    # Be nice to haven_labelled
    lab <- exattr(x, "label")
    if (!is.null(lab)) {
      cat("label: ", paste(format(lab), ""), "\n", sep = "")
    }
  }

  invisible(x)
}
