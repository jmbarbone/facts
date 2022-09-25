#' Fact reverse levels
#'
#' Reverse the levels of a `fact`
#'
#' @param x A `fact` object (or passed to [fact()])
fact_reverse  <- function(x) {
  x <- fact(x)
  lvls <- mark::flip(attr(x, "uniques"))
  seq <- mark::flip(seq_along(lvls))
  na <- attr(x, "na")

  if (na > 0) {
    lvls <- c(lvls[-1L], lvls[1L])
    seq <- c(seq[-1L], seq[1L])
  }

  new_fact(seq[x], levels = lvls, ordered = is.ordered(x), na = na)
}

