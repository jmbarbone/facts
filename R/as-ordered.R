#' Ordered
#'
#' As ordered
#'
#' @details Simple implementation of `ordered`.  If `x` is `ordered` it is
#' simply returned.  If `x` is a `factor` the `ordered` class is added.
#' Otherwise, `x` is made into a `factor` with [fact::fact()] and then the
#' `ordered` class is added. Unlike just `fact`, `ordered` will replace the `NA`
#' levels with `NA_integer_` to work appropriately with other functions.
#'
#' @inheritParams fact
#' @seealso [fact()]
#' @family factors
#' @export
#' @returns An `ordered` vector
#' @examples
#' x <- c("a", NA, "b")
#' x <- fact(x)
#' str(x) # NA is 3L
#'
#' y <- x
#' class(y) <- c("ordered", class(y))
#' max(y)
#' max(y, na.rm = TRUE) # returns NA -- bad
#'
#' # as_ordered() removes the NA level
#' x <- as_ordered(x)
#' str(x)
#' max(x, na.rm = TRUE) # returns b -- correct

as_ordered <- function(x) {
  UseMethod("as_ordered", x)
}

#' @rdname as_ordered
#' @export
as_ordered.default <- function(x) {
  res <- fact_na(x, remove = TRUE)

  if (!is.ordered(x)) {
    # TODO add_class(pos = 2)
    res <- add_class(res, c("fact", "ordered"), from_last = FALSE)
  }

  res
}
