#' Fact reverse levels
#'
#' Reverse the levels of a `fact` vector
#'
#' @param x A `fact` vector (or passed to [fact()])
#' @export
fact_reverse  <- function(x) {
  x <- fact(x)
  lvls <- rev(values(x))
  seq <- rev(seq_along(lvls))
  na <- exattr(x, "na")

  if (na > 0) {
    lvls <- c(lvls[-1L], lvls[1L])
    seq <- c(seq[-1L], seq[1L])
  }

  new_fact(seq[x], lvls, ordered = is.ordered(x), na = na)
}
