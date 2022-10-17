add_class <- function(x, cl, pos = 1L) {
  class(x) <- unique(c(class(x), cl), fromLast = TRUE)
  x
}

vap_lgl <- function(x, FUN, ...) {
  FUN <- match.fun(FUN)
  vapply(x, FUN, ..., FUN.VALUE = NA, USE.NAMES = FALSE)
}

struct <- function (x, class, ..., .keep_attr = FALSE) {
  attributes(x) <- if (isTRUE(.keep_attr)) {
    c(attributes(x), list(...))
  }
  else if (is.character(.keep_attr)) {
    c(attributes(x)[.keep_attr], list(...))
  }
  else {
    list(...)
  }
  class(x) <- class
  x
}

collapse0 <- function (..., sep = "") {
  ls <- list(...)
  paste0(unlist(ls), collapse = sep)
}
