
#' Object to values
#'
#' Converter for objects that store some value
#'
#' @param x An object
#' @param ... Additional parameters passed to methods
#' @return Values from `x`, of the same length as `x`
as_values <- function(x, ...) {
  UseMethod("as_values")
}

#' @export
#' @rdname as_values
#' @param fun An optional function for transforming values
as_values.default <- function(x, fun = "identity", ...) {
  match.fun(fun)(values(x), ...)
}

#' @export
#' @rdname as_values
as_values.fact <- function(x, ...) {
  as_values(values(x), ...)[unclass(x)]
}

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

guess_class <- function(x) {
  if (!is.character(x)) {
    return(class(x))
  }

  if (length(x) > 3000) {
    x <- sample(x, 2000)
  }

  if (all(is.na(x))) {
    return("logical")
  }

  num <- suppressWarnings(as.numeric(x))
  if (all(is.na(num))) {
    return("character")
  }

  num <- num[!is.na(num)]

  if (all(num %% 1 == 0)) {
    return("integer")
  }

  NULL
}
