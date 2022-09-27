exattr <- function(x, which) {
  attr(x, which = which, exact = TRUE)
}

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
