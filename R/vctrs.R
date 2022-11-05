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
  "fct"
}

fact_ptype2 <- function(x, y, ...) {
  values <- vec_c(values(x), value(y))
  fact(values)
}

fact_c <- function(x, y, ...) {
  fact(vec_c(values(x)[x], values(y)[y]), ...)
}

fact_ptype2 <- function(x, y, ...) {
  if (is.fact(x)) {
    if (is.fact(y)) {
      return(x)
    }

    fct <- x
    val <- y
  } else {
    fct <- y
    val <- x
  }

  # check to see if the values can be combined
  values <- vec_unique(vec_c(values(fct), val))
  vec
}

fact_mold <- function(x, y) {
  values <- vec_c(values(x), values(y))
  # to perform some coercion
  mold <- values(new_fact(values = vec_unique(values)))
  m <- vec_match(values, mold)
  new_fact(m, values = mold)
}

# ptype2 ------------------------------------------------------------------

# choose richer one

#' @export
vec_ptype2.fact.fact <- function(x, y, ...) { fact(vec_c(values(x), values(y))) }

#' @export
vec_ptype2.Date.fact <- function(x, y, ...) { y }
#' @export
vec_ptype2.fact.Date <- function(x, y, ...) { x }

#' @export
vec_ptype2.double.fact <- function(x, y, ...) { y }
#' @export
vec_ptype2.fact.double <- function(x, y, ...) { x }

#' @export
vec_ptype2.factor.fact <- function(x, y, ...) { y }
#' @export
vec_ptype2.fact.factor <- function(x, y, ...) { x }

#' @export
vec_ptype2.integer.fact <- function(x, y, ...) { y }
#' @export
vec_ptype2.fact.integer <- function(x, y, ...) { x }

#' @export
vec_ptype2.pseudo_id.fact <- function(x, y, ...) { y }
#' @export
vec_ptype2.fact.pseudo_id <- function(x, y, ...) { x }

# cast --------------------------------------------------------------------

### cast values to facts

#' @export
vec_cast.fact.fact <- function(x, to, ...) {
  # browser()
  values <- values(to)
  values <- values(fact(values))
  new_fact(
    vec_match(values(x)[x], values),
    values = values,
    ordered = is.ordered(x)
  )
}

#' @export
vec_cast.fact.Date <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.double <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.factor <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.haven_labelled <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.integer <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.logical <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.numeric <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.POSIXlt <- function(x, to, ...) { fact(x, ...) }
#' @export
vec_cast.fact.pseudo_id <- function(x, to, ...) { fact(x, ...) }

## from ----

## cast values from fact

#' @export
vec_cast.character.fact <- function(x, to, ...) { as.character(x, ...) }
#' @export
vec_cast.Date.fact <- function(x, to, ...) { as.Date(x, ...) }
#' @export
vec_cast.double.fact <- function(x, to, ...) { as.double(x, ...) }
#' @export
vec_cast.integer.fact <- function(x, to, ...) { as.integer(x, ...) }
#' @export
vec_cast.numeric.fact <- function(x, to, ...) { as.numeric(x, ...) }

