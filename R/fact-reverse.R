#' Fact reverse levels
#'
#' Reverse the levels of a `facts`
#'
#' @param x A `facts` object (or passed to [facts()])
fact_reverse  <- function(x) {
  x <- facts(x)
  lvls <- mark::flip(values(x))
  seq <- mark::flip(seq_along(lvls))
  na <- attr(x, "na")

  if (na > 0) {
    lvls <- c(lvls[-1L], lvls[1L])
    seq <- c(seq[-1L], seq[1L])
  }

  new_fact(seq[x], levels = lvls, ordered = is.ordered(x), na = na)
}
