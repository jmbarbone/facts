#' Drop levels
#'
#' Drop unused levels of a factor
#'
#' @param x A `factor` or `data.frame`
#' @param ... Additional arguments passed to methods (not used)
#' @seealso [base::droplevels]
#' @export
#' @family factors
drop_levels <- function(x, ...) {
  UseMethod("drop_levels", x)
}

#' @export
#' @rdname drop_levels
drop_levels.data.frame <- function(x, ...) {
  factors <- which(vapply(x, is.factor, NA))
  x[factors] <- lapply(x[factors], drop_levels)
  x
}

#' @export
#' @rdname drop_levels
drop_levels.fact <- function(x, ...) {
  if (is.ordered(x)) {
    as_ordered(as_values(x))
  } else {
    fact(as_values(x))
  }
}

#' @export
#' @rdname drop_levels
drop_levels.factor <- function(x, ...) {
  chr <- as.character(x)
  lvl <- levels(x) %wi% chr
  struct(
    vec_match(chr, lvl),
    class = vec_c(if (is.fact(x)) "fact", if (is.ordered(x)) "ordered", "factor"),
    levels = lvl
  )
}
