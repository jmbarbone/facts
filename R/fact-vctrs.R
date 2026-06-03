#' Internal [vctrs] methods
#'
#' Create `fact` vectors.
#'
#' @import vctrs
#' @keywords internal
#' @name fact-vctrs
NULL

# ptype2 ------------------------------------------------------------------

vec_ptype2_fact_fact <- function(x, y, ..., x_arg = "", y_arg = "") {
  tryCatch(
    vec_ptype2(
      exattr(x, "ptype"),
      exattr(y, "ptype"),
      ...,
      x_arg = x_arg,
      y_arg = y_arg
    ),
    vctrs_error_incompatible_type = function(err) {
      stop_incompatible_type(x, y, ..., x_arg = x_arg, y_arg = y_arg)
    }
  )

  fact(c(.values(x), .values(y)))
}

vec_ptype2_fact_factor <- function(x, y, ..., x_arg = "", y_arg = "") {
  # ignore x_arg and y_arg
  if (is.fact(x)) {
    x2 <- exattr(x, "ptype")
    y2 <- character()
  } else {
    x2 <- character()
    y2 <- exattr(x, "ptype")
  }

  tryCatch(
    vec_ptype2(x2, y2, ..., x_arg = x_arg, y_arg = y_arg),
    vctrs_error_incompatible_type = function(err) {
      stop_incompatible_type(x, y, ..., x_arg = x_arg, y_arg = y_arg)
    }
  )
}

#' @export
vec_ptype2.fact.fact <- vec_ptype2_fact_fact
#' @export
vec_ptype2.fact.factor <- vec_ptype2_fact_factor
#' @export
vec_ptype2.factor.fact <- vec_ptype2_fact_factor

vec_fact_ptype2 <- function(x, y, ..., x_arg = "", y_arg = "") {
  # ignore x_arg and y_arg
  if (is.fact(x)) {
    x2 <- exattr(x, "ptype")
  } else {
    x2 <- x
  }

  if (is.fact(y)) {
    y2 <- exattr(y, "ptype")
  } else {
    y2 <- y
  }

  tryCatch(
    vec_ptype2(x2, y2, ..., x_arg = x_arg, y_arg = y_arg),
    vctrs_error_incompatible_type = function(err) {
      stop_incompatible_type(x, y, ..., x_arg = x_arg, y_arg = y_arg)
    }
  )
}


#' @export
vec_ptype2.character.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.character <- vec_fact_ptype2
#' @export
vec_ptype2.logical.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.logical <- vec_fact_ptype2
#' @export
vec_ptype2.integer.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.integer <- vec_fact_ptype2
#' @export
vec_ptype2.double.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.double <- vec_fact_ptype2
#' @export
vec_ptype2.Date.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.Date <- vec_fact_ptype2
#' @export
vec_ptype2.POSIXct.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.POSIXct <- vec_fact_ptype2
#' @export
vec_ptype2.POSIXlt.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.POSIXlt <- vec_fact_ptype2
#' @export
vec_ptype2.complex.fact <- vec_fact_ptype2
#' @export
vec_ptype2.fact.complex <- vec_fact_ptype2

# cast --------------------------------------------------------------------

#' @export
#' @export
vec_cast.fact.fact <- function(x, to, ...) {
  # 'to' is the mold
  new_fact(
    vec_match(.values(x), .values(to))[x],
    levels(to),
    ptype = exattr(to, "ptype")
  )
}

# others ------------------------------------------------------------------

#' @export
is.na.fact <- function(x) {
  get_values(x, is.na)
}

#' @export
is.nan.fact <- function(x) {
  get_values(x, is.nan)
}

#' @export
is.finite.fact <- function(x) {
  get_values(x, is.infinite)
}

#' @export
is.infinite.fact <- function(x) {
  get_values(x, is.infinite)
}
