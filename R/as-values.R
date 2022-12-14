
#' Object to values
#'
#' Converter for objects that store some value
#'
#' @param x An object
#' @param ... Additional paramters passed to methods
#' @return Values from `x`, of the same length as `x`
as_values <- function(x, ...) {
  UseMethod("as_values")
}

#' @export
#' @rdname as_values
as_values.default <- function(x, ...) {
  x
}

#' @export
#' @rdname as_values
#' @param fun An optional function for transforming values
as_values.pseudo_id <- function(x, fun = "identity", ...) {
  fun <- match.fun(fun)
  fun(values(x))[x]
}


#' @export
#' @rdname as_values
as_values.fact <- as_values.pseudo_id

#' @export
#' @rdname as_values
#' @param type Either one of `"character"`, `"double"`, `"integer"`, or `"date"`
#'   or a `function` (or name of one as a `character`).  This determines how to
#'   convert the result of `levels(x)`.
as_values.factor <- function(x, type = c("character", "double", "integer", "date"), ...) {
  if (is.function(type)) {
    return(type(levels(x))[x])
  }

  switch(
    type[1],
    character = levels(x)[x],
    double = as.double(levels(x))[x],
    integer = as.integer(levels(x))[x],
    date = as.Date(levels(x))[x],
    {
      if (!is.function(type)) {
        type <- match.fun(type)
      }

      type(levels(x))[x]
    }
  )
}
