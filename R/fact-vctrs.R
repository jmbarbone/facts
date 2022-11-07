#' Internal [{vctrs}] methods
#'
#' @import vctrs
#' @keywords internal
#' @name fact-vctrs
NULL

new_fact <- function(
    x = integer(),
    values = NULL,
    levels = NULL,
    ordered = FALSE,
    range = NULL,
    na = if (anyNA(values)) length(values) else 0L
) {
  values <- values %||% unique(x)
  struct(
    as.integer(x),
    class = c("fact", if (ordered) "ordered", "factor", "vctrs_vctr"),
    levels = to_levels(levels %||% values),
    values = values,
    range = range,
    na = na
  )
}

#' @export
vec_ptype_abbr.fact <- function(x, ...) {
  if (is.ordered(x)) "fctor" else "fct"
}

fact_ptypes <- function(x, y, ..., x_arg = "", y_arg = "") {
  x_val <- values(x)
  y_val <- values(y)
  mold <- try(vec_c(x_val, y_val), silent = TRUE)

  if (inherits(mold, "try-error")) {
    msg <- sprintf(
      fmt = c(
        "unable to convert values of the `fact` objects",
        "attr(%s, \"value\") and attr(%s, \"value\") are not compatible"
      ),
      x_arg,
      y_arg
    )
    stop_incompatible_type(
      x = x_val,
      y = y_val,
      x_arg = x_arg,
      y_arg = y_arg,
      details = msg
    )
  }

  if (is.factor(x) & is.factor(y)) {
    fact(mold)
  } else {
    mold[0]
  }
}

# ptype2 ------------------------------------------------------------------

# TODO rethink this...
# choose richer one

#' @export
vec_ptype2.fact.fact <- fact_ptypes

#' @export
vec_ptype2.character.fact <- fact_ptypes
#' @export
vec_ptype2.fact.character <- fact_ptypes

#' @export
vec_ptype2.Date.fact <- fact_ptypes
#' @export
vec_ptype2.fact.Date <- fact_ptypes

#' @export
vec_ptype2.double.fact <- fact_ptypes
#' @export
vec_ptype2.fact.double <- fact_ptypes

#' @export
vec_ptype2.factor.fact <- fact_ptypes
#' @export
vec_ptype2.fact.factor <- fact_ptypes

#' @export
vec_ptype2.integer.fact <- fact_ptypes
#' @export
vec_ptype2.fact.integer <- fact_ptypes

#' @export
vec_ptype2.logical.fact <- fact_ptypes
#' @export
vec_ptype2.fact.logical <- fact_ptypes

# cast --------------------------------------------------------------------

## values to facts ----

vec_cast_fact_levels <- function(x, to, ...) {
  values <- values(to)
  values <- values(fact(values))
  new_fact(
    vec_match(values(x)[x], values),
    values = values,
    ordered = is.ordered(x)
  )
}

vec_cast_fact_default <- function(x, to, ...) {
  res <- fact(vec_c(x, values(to)))
  res[vec_match(x, values(res))]
}

#' @export
vec_cast.fact.fact <- vec_cast_fact_levels
#' @export
vec_cast.fact.factor <- vec_cast_fact_levels
#' @export
vec_cast.fact.haven_labelled <- vec_cast_fact_levels

#' @export
vec_cast.fact.character <- vec_cast_fact_default
#' @export
vec_cast.fact.Date <- vec_cast_fact_default
#' @export
vec_cast.fact.double <- vec_cast_fact_default
#' @export
vec_cast.fact.integer <- vec_cast_fact_default
#' @export
vec_cast.fact.logical <- vec_cast_fact_default
#' @export
vec_cast.fact.POSIXlt <- vec_cast_fact_default

## fact to values ----

#' @export
vec_cast.character.fact <- function(x, to, ...) { levels(x)[x] }
#' @export
vec_cast.Date.fact <- function(x, to, ...) { as.Date(values(x)[x], ...) }
#' @export
vec_cast.factor.fact <- function(x, to, ...) { factor(values(x), labels = levels(x))[x] }
#' @export
vec_cast.double.fact <- function(x, to, ...) { as.double(values(x))[x] }
#' @export
vec_cast.integer.fact <- function(x, to, ...) { as.integer(x) }
#' @export
vec_cast.logical.fact <- function(x, to, ...) { as.logical(values(x)[x]) }

