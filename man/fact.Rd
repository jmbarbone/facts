% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fact.R
\name{fact}
\alias{fact}
\alias{fact.default}
\alias{fact.character}
\alias{fact.numeric}
\alias{fact.integer}
\alias{fact.Date}
\alias{fact.POSIXt}
\alias{fact.logical}
\alias{fact.factor}
\alias{fact.fact}
\alias{fact.pseudo_id}
\title{Factor}
\usage{
fact(x, ...)

\method{fact}{default}(x, ...)

\method{fact}{character}(x, levels = NULL, ...)

\method{fact}{numeric}(x, ...)

\method{fact}{integer}(x, range = NULL, ...)

\method{fact}{Date}(x, range = NULL, ...)

\method{fact}{POSIXt}(x, ...)

\method{fact}{logical}(x, ...)

\method{fact}{factor}(x, ...)

\method{fact}{fact}(x, ...)

\method{fact}{pseudo_id}(x, ...)
}
\arguments{
\item{x}{A vector of values}

\item{...}{Additional arguments passed to methods}

\item{levels}{Optional specification of levels for `x`.  When `NULL`, will
default to all the unique values of `x` in the order they appear.
Duplicated values are silently dropped.}

\item{range}{Controls setting of additional labels.  Accepts a numeric vector
that can be safely coerced to an `integer`.  A sequence of `integers` is
reconstructed from `range` and used as all the `fact` levels.  All `NA` and
`Inf` values are dropped.  At least one non-missing and finite value must
be present.}
}
\value{
A vector of equal length of `x` with class `fact` and `factor`.  If
  `x` was `ordered`, that class is added in between.
}
\description{
Quickly create a factor
}
\details{
`fact()` can be about 5 times quicker than `factor()` or
  `as.factor()` as it doesn't bother sorting the levels for non-numeric data
  or have other checks or features.  It simply converts a vector to a factor
  with all unique values as levels with `NA`s included.

  `fact.factor()` will perform several checks on a factor to include `NA`
  levels and to check if the levels should be reordered to conform with the
  other methods.  The `fact.fact()` method simple returns `x`.
}
\section{level orders}{


The order of the levels may be adjusted to these rules depending on the class
of `x`:
\describe{
  \item{`character`}{The order of appearance}
  \item{`numeric`/`integer`/`Date`/`POSIXt`}{By the numeric order}
  \item{`logical`}{As `TRUE`, `FALSE`, then `NA` if present}
  \item{`factor`}{Numeric if levels can be safely converted, otherwise as
  they are}
}
}

\seealso{
[as_ordered()]

Other factors: 
\code{\link{as_ordered}()},
\code{\link{drop_levels}()},
\code{\link{fact_na}()}
}
\concept{factors}
