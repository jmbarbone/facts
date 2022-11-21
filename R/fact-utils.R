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
to_levels <- function(x, na = NULL) {
  na <- fact_na_label(na)
  nas <- is.na(x)
  x <- as.character(x)
  x[nas] <- na
  x
}

fact_na_label <- function(na = NULL) {
  na <- na %||% getOption("facts.na.label", "(na)")
  na <- as.character(na)

  if (length(na) != 1) {
    stop(fact_na_condition())
  }

  na
}

fact_coerce_levels <- function(x) {
  nas <- is.na(x)

  if (all(nas) || !anyNA(match(x[!nas], c("TRUE", "FALSE")))) {
    return(as.logical(x))
  }

  # TODO use utils::type.convert(as.is = TRUE) and then check if still character

  tz <- getOption("mark.default_tz", "UTC")
  wuffle({
    numbers <- as.numeric(x[!nas])
    dates <- as.Date(x[!nas], optional = TRUE)
    posix <- as.POSIXct(
      x          = x[!nas],
      tryFormats = c("%Y-%m-%d %H:%M:%OS", "%Y/%m/%d %H:%M:%OS",
                     "%Y-%m-%d %H %M %S", "%Y %m %d %H %M %S",
                     "%Y-%m-%d %H%M%S", "%Y %m %d %H%M%S",
                     "%Y%m%d %H %M %S", "%Y%m%d %H%M%S"),
      tz         = tz,
      optional   = TRUE
    )
  })

  n <- length(x)

  if (!anyNA(dates) && all(nchar(x[!nas]) == 10L)) {
    x <- rep(as.Date(NA), n)
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

    if (is_integerish(numbers)) {
      x <- rep(NA_integer_, n)
      x[!nas] <- as.integer(numbers)
    } else {
      x <- rep(NA_real_, n)
      x[!nas] <- numbers
    }
  }

  x
}

fact_set_levels <- function(x, levels = NULL, range = NULL) {

}

`fact_levels<-` <- function(x, value) {
  x <- fact(x)
  levels <- levels(x)
  value <- vec_c(value, if (!anyNA(value) & (anyNA(x) | anyNA(levels))) NA)
  new_fact(
    x = vec_match(levels, as.character(value))[x],
    values = value,
    ordered = is.ordered(x)
  )
}

is.fact <- function(x) {
  inherits(x, "fact")
}

is_fact <- is.fact

check_fact <- function(x) {
  if (!is.fact(x)) {
    stop(fact_inherits_condition())
  }

  invisible(x)
}
