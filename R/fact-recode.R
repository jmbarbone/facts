fact_recode <- function(x, ..., old = NULL, new = NULL) {
  x <- fact(x)
  vals <- list(...)

  if (length(vals)) {
    if (!is.null(old) || !is.null(new)) {
      stop(fact_recode_dots_condition())
    }

    old <- as.vector(vals)
    # names checked below
    new <- names(vals)
  }

  if (is.null(new)) {
    stop(fact_recode_new_condition())
  }

  if (is.null(old)) {
    old <- values(x)
  }

  if (!length(old)) {
    stop(fact_recode_old_condition())
  }

  # x <- fact(sample(1:10, 100, TRUE))
  # old <- c(2, 4)
  # new <- c(1, 3)
  new_vals <- old_vals <- values(x)

  if (is.numeric(old_vals)) {
    old <- as.numeric(old)
    new <- as.numeric(new)
  }

  for (i in seq_along(old)) {
    new_vals[old_vals == old[i]] <- new[i]
  }

  fact(new_vals[x])
}

# x <- fact(sample(1:10, 100, TRUE))
# fact_recode(x, "2" = list(1:3), "0" = list(9:10))
