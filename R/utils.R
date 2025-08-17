is_integerish <- function(x, bool = getOption("facts.bool.integer", FALSE)) {
  if (is.integer(x) || (isTRUE(bool) && is.logical(x))) {
    return(TRUE)
  }

  # Date, POSIXt return TRUE for is.double()
  if (!is.numeric(x)) {
    return(FALSE)
  }

  x <- x[!is.na(x)]

  if (!length(x)) {
    return(TRUE)
  }

  all(x %% 1 == 0)
}

cat0 <- function(...) {
  cat(..., sep = "")
}

values <- function(x, strict = FALSE) {
  out <- exattr(x, "values") %||% exattr(x, "levels")

  if (!strict && is.null(out)) {
    vec_unique(x)
  } else {
    out
  }
}

add_class <- function(x, cl, pos = 1L, from_last = TRUE) {
  class(x) <- unique(
    append(class(x), cl, after = pos - 1L),
    fromLast = from_last
  )
  x
}
