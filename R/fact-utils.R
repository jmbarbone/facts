new_fact <- function(
    x,
    levels,
    ordered = FALSE,
    na = if (anyNA(levels)) length(levels) else 0L
) {
  struct(
    as.integer(x),
    class = c("fact", if (ordered) "ordered", "factor"),
    levels = as.character(levels),
    uniques = levels,
    na = na
  )
}

try_numeric <- function(x) {
  if (is.numeric(x)) {
    return(x)
  }

  nas <- is.na(x)

  if (all(nas)) {
    return(x)
  }

  nums <- wuffle(as.numeric(x[!nas]))

  if (anyNA(nums)) {
    return(x)
  }

  out <- rep(NA_real_, length(x))
  out[!nas] <- nums
  out
}

fact_values <- function(x) {
  if (!is.fact(x)) {
    stop("x must be a fact object", call. = FALSE)
  }

  attr(x, "uniques")[as.integer(x)]
}

fact_coerce_levels <- function(x) {
  nas <- is.na(x)

  if (all(nas) || !anyNA(match(x[!nas], c("TRUE", "FALSE")))) {
    return(as.logical(x))
  }

  tz <- getOption("mark.default_tz", "UTC")
  wuffle({
    numbers <- as.numeric(x[!nas])
    dates <- as.Date(x[!nas], optional = TRUE)
    posix <- as.POSIXct(
      x          = x[!nas],
      tryFormats = try_formats(),
      tz         = tz,
      optional   = TRUE
    )
  })

  n <- length(x)

  if (!anyNA(dates) && all(nchar(x[!nas]) == 10L)) {
    x <- rep(NA_Date_, n)
    x[!nas] <- dates
  } else if (!anyNA(posix)) {
    x <- rep(NA_real_, n)
    stopifnot(all(!nas))
    x[] <- as.double(posix)
    x <- as.POSIXct(
      x          = x,
      origin     = "1970-01-01",
      tz         = tz
    )
  } else if (!anyNA(numbers)) {
    x <- rep(NA_real_, n)
    x[!nas] <- numbers
  }

  x
}

`fact_levels<-` <- function(x, value) {
  x <- fact(x)
  levels <- levels(x)
  value <- vec_c(value, if (!anyNA(value) & (anyNA(x) | anyNA(levels))) NA)
  new_fact(vec_match(levels, as.character(value))[x], value, is.ordered(x))
}

is.fact <- function(x) {
  inherits(x, "fact")
}
