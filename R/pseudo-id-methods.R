#' Print `pseudo_id`
#' @export
#' @param x An object of class [pseudo_id]
#' @param ... Not implemented
#' @param all if `TRUE` will print all values  This is not recommend for many
#'   values as it will crowd the console output
#' @returns `x`, invisibly.  Called for its side effects.
#' @seealso [pseudo_id()]
print.pseudo_id <- function(x, ..., all = FALSE) {
  print(as.integer(x))
  out <- collapse("values: ", paste0(values(x), sep = " "), sep = "")
  if (!all) {
    width <- getOption("width", 180)
    if (nchar(out) > width) {
      out <- substr(out, 1, width - 4)
      out <- paste0(out, " ...")
    }
  }
  cat0(out, "\n")
  invisible(x)
}

#' @export
format.pseudo_id <- function(x, ...) {
  vals <- values(x)
  ints <- seq_along(vals)
  sprintf("%s <%s>", format(ints), format(vals))[x]
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.pseudo_id <- function(x, ...) {
  pillar::new_pillar_shaft_simple(format(x))
}

#' @export
as.integer.pseudo_id <- function(x, ...) { vec_cast(x, integer()) }
#' @export
as.double.pseudo_id <- function(x, ...) { vec_cast(x, double()) }
#' @export
as.numeric.pseudo_id <- function(x, ...) { vec_cast(x, numeric()) } # nocov
