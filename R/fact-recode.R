fact_recode <- function(x, ..., old = NULL, new = NULL) {
  if (is.null(old) & is.null(new)) {
    vals <- list(...)
    new <- names(vals)
    old <- as.vector(vals)
  }

  if (is.null(old) | is.null(new)) {
    stop("no!")
  }

  # x <- fact(sample(1:10, 100, TRUE))
  # old <- c(2, 4)
  # new <- c(1, 3)
  new_vals <- old_vals <- values(x)

  if (is.numeric(u)) {
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
