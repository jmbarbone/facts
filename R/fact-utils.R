new_fact <- function(
    x,
    values,
    levels = to_levels(values),
    ordered = FALSE,
    range = NULL,
    na = if (anyNA(values)) length(values) else 0L
) {
  mark::struct(
    as.integer(x),
    class = c("facts", if (ordered) "ordered", "factor"),
    levels = if (is.null(levels)) to_levels(values) else to_levels(levels),
    values = values,
    range = range,
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

# Safely transform values into labels and use a replacement for NA values
to_levels <- function(x, na = getOption("facts.na.label", "(na)")) {
  if (length(na) != 1L & is.character(na)) {
    stop("na label must be a character vector of length 1", call. = FALSE)
  }

  nas <- is.na(x)
  x <- as.character(x)
  x[nas] <- na
  x
}

fact_values <- function(x) {
  if (!is.facts(x)) {
    stop("x must be a facts object", call. = FALSE)
  }

  .Deprecated("as_values")
  as_values(x)
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

fact_set_levels <- function(x, levels = NULL, range = NULL) {

}

`fact_levels<-` <- function(x, value) {
  x <- facts(x)
  levels <- levels(x)
  value <- vec_c(value, if (!anyNA(value) & (anyNA(x) | anyNA(levels))) NA)
  new_fact(vec_match(levels, as.character(value))[x], value, is.ordered(x))
}

is.facts <- function(x) {
  inherits(x, "facts")
}
