#' @export
print.fact <- function(
  x,
  max_levels = getOption("mark.fact.max_levels", TRUE),
  width = getOption("width"),
  ...
) {
  # mostly a reformatted base::print.factor()
  ord <- is.ordered(x)
  if (length(x) == 0L) {
    cat(if (ord) "ordered" else "fact", "(0)\n", sep = "")
  } else {
    print(values(x), quote = FALSE, ...)
  }

  if (max_levels) {
    lev <- encodeString(levels(x), quote = "")
    n <- length(lev)
    colsep <- if (ord) " < " else " "

    valstring <- sprintf("<%s>: ", vec_ptype_full(exattr(x, "ptype")))
    if (is.logical(max_levels)) {
      max_levels <- {
        width <- width - (nchar(valstring, "w") + 3L + 1L + 3L)
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
      valstring,
      paste(
        if (drop) {
          c(
            lev[1:max(1L, max_levels - 1L)],
            "...",
            if (max_levels > 1L) lev[n]
          )
        } else {
          lev
        },
        collapse = colsep
      ),
      "\n",
      sep = ""
    )
  }

  invisible(x)
}
