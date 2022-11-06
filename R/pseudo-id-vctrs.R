
new_pseudo_id <- function(x = integer(), values = integer(), ..., u) {
  if (!missing(u)) {
    # TODO fix this
    values <- u
  }

  struct(
    x = x,
    class = c("pseudo_id", "integer", "vctrs_vctr"),
    values = values
  )
}

#' @export
vec_ptype_abbr.pseudo_id <- function(x, ...) {
  "pid"
}

pseudo_id_ptypes <- function(x, y, ..., x_arg = "", y_arg = "") {
  x_val <- values(x) %||% vec_unique(x)
  y_val <- values(y) %||% vec_unique(y)
  mold <- try(pseudo_id(vec_c(x_val, y_val)), silent = TRUE)

  if (inherits(mold, "try-error")) {
    msg <- sprintf(
      fmt = c(
        "unable to convert values of the `pseudo_id` object(s)",
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

  mold
}

# ptype2 ------------------------------------------------------------------

# TODO rethink this...
# choose richer one

#' @export
vec_ptype2.pseudo_id.pseudo_id <- pseudo_id_ptypes

#' @export
vec_ptype2.Date.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.Date <- pseudo_id_ptypes

#' @export
vec_ptype2.double.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.double <- pseudo_id_ptypes

#' @export
vec_ptype2.pseudo_idor.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.pseudo_idor <- pseudo_id_ptypes

#' @export
vec_ptype2.integer.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.integer <- pseudo_id_ptypes

#' @export
vec_ptype2.logical.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.logical <- pseudo_id_ptypes

# cast --------------------------------------------------------------------

## values to pseudo_id ----

#' @export
vec_cast.pseudo_id.pseudo_id <- function(x, to, ...) {
  # browser()
  values <- values(to)
  new_pseudo_id(
    vec_match(values(x)[x], values),
    values = values,
  )
}

pseudo_id_cast <- function(x, to, ...) { pseudo_id(x, ...) }

#' @export
vec_cast.pseudo_id.Date <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.double <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.pseudo_idor <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.haven_labelled <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.integer <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.logical <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.numeric <- pseudo_id_cast
#' @export
vec_cast.pseudo_id.POSIXlt <- pseudo_id_cast

## pseudo_id to values ----

# maybe not?

#' @export
vec_cast.character.fact <- function(x, to, ...) { as.character(x, ...) }
#' @export
vec_cast.Date.fact <- function(x, to, ...) { as.Date(x, ...) }
#' @export
vec_cast.double.fact <- function(x, to, ...) { as.double(unclass(x)) }
#' @export
vec_cast.integer.fact <- function(x, to, ...) { x }
#' @export
vec_cast.numeric.fact <- function(x, to, ...) { as.numeric(unclass(x)) }

#' @export
as.integer.pseudo_id <- function(x, ...) {
  x <- unclass(x)
  attributes(x) <- NULL
  x
}

