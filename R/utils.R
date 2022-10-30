is_integerish <- function(x, bool = getOption("facts.bool.integer", FALSE)) {
  if (is.integer(x) | (isTRUE(bool) & is.logical(x))) {
    return(TRUE)
  }

  if (!is.double(x)) {
    return(FALSE)
  }

  x <- x[!is.na(x)]

  if (!length(x)) {
    return(TRUE)
  }

  all(x %% 1 == 0)
}

cat0 <- function(...) {
  cat(..., sep = "" )
}

values <- function(x) {
  exattr(x, "values")
}

last <- function(x) {
  x[length(x)]
}

add_class <- function(x, cl, pos = 1L, from_last = TRUE) {
  class(x) <- unique(append(class(x), cl, after = pos - 1L), fromLast = from_last)
  x
}

vap_lgl <- function(x, FUN, ...) {
  FUN <- match.fun(FUN)
  vapply(x, FUN, ..., FUN.VALUE = NA, USE.NAMES = FALSE)
}
