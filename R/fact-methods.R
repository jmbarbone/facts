
#' @export
as.integer.fact <- function(x, ...) {
  as_values(x, as.integer)
}

#' @export
as.double.fact <- function(x, ...) {
  as_values(x, as.double)
}

#' @export
as.character.fact <- function(x, ...) {
  as_values(x, as.character)
}

# because unique.factor() remakes factor
# this won't drop levels
#' @export
unique.fact <- function(x, incomparables = FALSE, ...) {
  att <- attributes(x)
  struct(
    unique(unclass(x)),
    class = att$class,
    levels = att$levels,
    values = att$values,
    na = att$na
  )
}

#' @export
as.Date.fact <- function(x, ...) {
  as.Date(values(x), ...)[x]
}

#' @export
`[.fact` <- function(x, ...)  {
  y <- NextMethod("[")
  attributes(y) <- attributes(x)
  y
}

#' @export
levels.fact <- function(x) {
  exattr(x, "levels")
}

#' @export
format.fact <- function(x, ...) {
  vals <- values(x)
  ints <- seq_along(vals)
  sprintf("%s [%s]", format(ints), format(vals))[x]
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.fact <- function(x, ...) {
  pillar::new_pillar_shaft_simple(format(x))
}

#' @export
print.fact <- function(
    x,
  max_levels = getOption("facts.max_levels", TRUE),
  width = getOption("width"),
  ...
) {
  # mostly a reformatted base::print.factor()
  # TODO check for `range` attribute and print something a bit nicer
  ord <- is.ordered(x)
  if (length(x) == 0L) {
    cat(if (ord) "ordered" else "factor", "(0)\n", sep = "")
  } else {
    print(as.character(x), quote = FALSE, ...)
  }

  if (max_levels) {
    lev <- encodeString(levels(x), quote = "")
    n <- length(lev)
    colsep <- if (ord) " < " else " "

    if (length(range <- exattr(x, "range")) == 2L) {
      lab <- cat(
        "range: ", range[1L], " to ", range[2L],
        if (na <- exattr(x, "na")) c(", ", levels(x)[na]),
        "\n",
        sep = ""
      )
    } else {
      T0 <- "levels: "
      if (is.logical(max_levels)) {
        max_levels <- {
          width <- width - (nchar(T0, "w") + 3L +  1L + 3L)
          lenl <- cumsum(nchar(lev, "w") + nchar(colsep, "w"))

          if (n <= 1L || lenl[n] <= width) {
            n
          } else {
            max(1L, which.max(lenl > width) - 1L)
          }
        }
      }
      drop <- n > max_levels
      cat(
        if (drop) paste(format(n), ""),
        T0,
        paste(
          if (drop) {
            c(lev[1L:max(1, max_levels - 1)], "...", if (max_levels >  1) lev[n])
          } else {
            lev
          },
          collapse = colsep
        ),
        "\n",
        sep = ""
      )
    }

    # Be nice to haven_labelled
    lab <- exattr(x, "label")
    if (!is.null(lab)) {
      cat("label: ", paste(format(lab), ""), "\n", sep = "")
    }
  }

  invisible(x)
}
