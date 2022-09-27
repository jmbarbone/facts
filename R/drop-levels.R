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
  factors <- which(mark::vap_lgl(x, is.factor))
  x[factors] <- lapply(x[factors], drop_levels)
  x
}

#' @export
#' @rdname drop_levels
drop_levels.facts <- function(x, ...) {
  if (is.ordered(x)) {
    as_ordered(fact_values(x))
  } else {
    facts(fact_values(x))
  }
}

#' @export
#' @rdname drop_levels
drop_levels.factor <- function(x, ...) {
  chr <- as.character(x)
  lvl <- levels(x) %wi% chr
  mark::struct(
    vec_match(chr, lvl),
    class = vec_c(if (is.facts(x)) "facts", if (is.ordered(x)) "ordered", "factor"),
    levels = lvl
  )
}
