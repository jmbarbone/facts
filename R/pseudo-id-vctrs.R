
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
  x_val <- values(x)
  y_val <- values(y)
  mold <- try(vec_c(x_val, y_val), silent = TRUE)

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

  if (is_pseudo_id(x) | is.factor(x) & is_pseudo_id(y) & is.factor(y)) {
    pseudo_id(mold)
  } else {
    mold[0]
  }
}

# ptype2 ------------------------------------------------------------------

do_ptype <- function(value) {
  fun <- function(x, y, ..., x_arg = "", y_arg = "") { }
  body(fun) <- substitute(value)
  fun
}

# choose richer one

#' @export
vec_ptype2.pseudo_id.pseudo_id <- pseudo_id_ptypes

#' @export
vec_ptype2.character.pseudo_id <- do_ptype(character())
#' @export
vec_ptype2.pseudo_id.character <- do_ptype(character())

#' @export
vec_ptype2.Date.pseudo_id <- do_ptype(new_date())
#' @export
vec_ptype2.pseudo_id.Date <- do_ptype(new_date())

#' @export
vec_ptype2.double.pseudo_id <- do_ptype(double())
#' @export
vec_ptype2.pseudo_id.double <- do_ptype(double())

#' @export
vec_ptype2.factor.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.factor <- pseudo_id_ptypes

#' @export
vec_ptype2.fact.pseudo_id <- pseudo_id_ptypes
#' @export
vec_ptype2.pseudo_id.fact <- pseudo_id_ptypes

#' @export
vec_ptype2.integer.pseudo_id <- do_ptype(integer())
#' @export
vec_ptype2.pseudo_id.integer <- do_ptype(integer())

#' @export
vec_ptype2.logical.pseudo_id <- do_ptype(logical())
#' @export
vec_ptype2.pseudo_id.logical <- do_ptype(logical())

# cast --------------------------------------------------------------------

## values to pseudo_id ----

vec_cast_pseudo_id_values <- function(x, to, ...) {
  values <- values(to)
  new_pseudo_id(
    vec_match(values(x)[x], values),
    values = values,
  )
}

vec_cast_pseudo_id_default <- function(x, to, ...) {
  res <- pseudo_id(vec_c(x, values(to)))
  res[vec_match(x, values(res))]
}

#' @export
vec_cast.pseudo_id.pseudo_id <- vec_cast_pseudo_id_values
#' @export
vec_cast.pseudo_id.fact <- vec_cast_pseudo_id_values
#' @export
vec_cast.pseudo_id.factor <- vec_cast_pseudo_id_values
#' @export
vec_cast.pseudo_id.haven_labelled <- vec_cast_pseudo_id_values

#' @export
vec_cast.pseudo_id.character <- vec_cast_pseudo_id_default
#' @export
vec_cast.pseudo_id.Date <- vec_cast_pseudo_id_default
#' @export
vec_cast.pseudo_id.double <- vec_cast_pseudo_id_default
#' @export
vec_cast.pseudo_id.integer <- vec_cast_pseudo_id_default
#' @export
vec_cast.pseudo_id.logical <- vec_cast_pseudo_id_default
#' @export
vec_cast.pseudo_id.numeric <- vec_cast_pseudo_id_default
#' @export
vec_cast.pseudo_id.POSIXlt <- vec_cast_pseudo_id_default

## pseudo_id to values ----

# maybe not?

#' @export
vec_cast.character.pseudo_id <- function(x, to, ...) { vec_cast(values(x), character())[x] }
#' @export
vec_cast.Date.pseudo_id <- function(x, to, ...) { vec_cast(values(x), new_date())[x] }
#' @export
vec_cast.double.pseudo_id <- function(x, to, ...) { vec_cast(values(x), double())[x] }
#' @export
vec_cast.integer.pseudo_id <- function(x, to, ...) { struct(x, "integer") }
#' @export
vec_cast.numeric.pseudo_id <- function(x, to, ...) { vec_cast(values(x), numeric())[x] }

#' @export
as.integer.pseudo_id <- function(x, ...) {
  vec_cast(x, integer())
}
