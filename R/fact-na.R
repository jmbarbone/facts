#' `fact` with `NA`
#'
#' Included `NA` values into `fact()`
#'
#' @details
#' This re-formats the `x` value so that `NA`s are found immediately within the
#' object rather than accessed through its attributes.
#'
#' @param x A `fact` or object cohered to `fact`
#' @param remove If `TRUE` removes `NA` value from the `fact` `levels` and
#'   `values` attributes
#' @returns A `fact` vector
#' @family factors
#' @export
fact_na <- function(x, remove = FALSE) {
  x <- fact(x)
  na <- attr(x, "na")

  if (na == 0L) {
    return(x)
  }

  if (remove) {
    attr(x, "levels")  <- exattr(x, "levels")[-na]
    attr(x, "values") <- exattr(x, "values")[-na]
  }

  a <- attributes(x)
  x <- unclass(x)
  x[x == na] <- NA_integer_
  attributes(x) <- a
  attr(x, "na") <- 0L
  x
}
