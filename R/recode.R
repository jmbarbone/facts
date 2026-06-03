# FIXME rexport recode() from fuj

#' PLACEHOLDER
#'
#' PLACEHOLDER
#'
#' @param x,...,.list,.nomatch PLACEHOLDER
#' @examples
#' # PLACEHOLDER
#'
#' x <- fact(c(1, 1, 3, 0, 2))
#' recode(x, 1 ~ -1, 0 ~ NA)
#'
#' @export
recode <- function(x, ..., .list = list(...), .nomatch = c("na", "keep")) {
  if (length(.list) == 0L) {
    return(x)
  }

  forms <- vapply(.list, \(i) inherits(i, "formula"), NA, USE.NAMES = FALSE)

  .list[forms] <- lapply(
    .list[forms],
    \(i) {
      list(as.list(i)[[2L]], as.list(i)[[3L]])
    }
  )

  .list[!forms] <- .mapply(
    list,
    list(names(.list[!forms]), .list[!forms]),
    NULL
  )

  from <- lapply(.list, \(i) eval.parent(i[[1L]]))
  to <- lapply(.list, \(i) eval.parent(i[[2L]]))
  # browser()
  recode_vec(x, from, to, .nomatch)
}

recode_vec <- function(x, from, to, nomatch = c("na", "keep")) {
  if (is.factor(x)) {
    # TODO consider if sorting should be applied for fact()
    levels(x) <- recode_vec(levels(x), from, to, nomatch)
    return(x)
  }

  # browser()
  nomatch <- match_arg(nomatch)
  m <- match(x, from, NA_integer_)
  switch(
    nomatch,
    na = {
      is.na(x) <- is.na(m)
    },
    keep = NULL,
    stop(internal_error()) # nocov
  )

  replace <- to[remove_na(m)]

  if (!is.list(x)) {
    replace <- unlist(replace)
  }

  x[which(!is.na(m))] <- replace
  x
}

remove_na <- function(x) x[!is.na(x)]

# # recode(1:3, 1 ~ "a", "2" = "b", .nomatch = "keep")
# recode(list(1, 2, 3), "2" = "b", .nomatch = "keep")
