% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as-values.R
\name{as_values}
\alias{as_values}
\alias{as_values.default}
\alias{as_values.pseudo_id}
\alias{as_values.fact}
\alias{as_values.factor}
\title{Object to values}
\usage{
as_values(x, ...)

\method{as_values}{default}(x, ...)

\method{as_values}{pseudo_id}(x, fun = "identity", ...)

\method{as_values}{fact}(x, fun = "identity", ...)

\method{as_values}{factor}(x, type = c("character", "double", "integer", "date"), ...)
}
\arguments{
\item{x}{An object}

\item{...}{Additional paramters passed to methods}

\item{fun}{An optional function for transforming values}

\item{type}{Either one of `"character"`, `"double"`, `"integer"`, or `"date"`
or a `function` (or name of one as a `character`).  This determines how to
convert the result of `levels(x)`.}
}
\value{
Values from `x`, of the same length as `x`
}
\description{
Converter for objects that store some value
}
