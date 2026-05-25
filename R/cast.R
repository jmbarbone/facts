cast <- function(x, y) {
  UseMethod("cast", y)
}

#' @export
cast.character <- function(x, y) {
  x
}

#' @export
cast.logical <- function(x, y) {
  as.logical(x)
}

#' @export
cast.integer <- function(x, y) {
  as.integer(x)
}

#' @export
cast.double <- function(x, y) {
  as.double(x)
}

#' @export
cast.numeric <- function(x, y) {
  as.numeric(x)
}

#' @export
cast.Date <- function(x, y) {
  as.Date(x)
}

#' @export
cast.POSIXct <- function(x, y) {
  as.POSIXct(x)
}

#' @export
cast.POSIXlt <- function(x, y) {
  as.POSIXlt(x)
}

#' @export
cast.complex <- function(x, y) {
  as.complex(x)
}
