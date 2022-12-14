% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as-ordered.R
\name{as_ordered}
\alias{as_ordered}
\alias{as_ordered.default}
\title{Ordered}
\usage{
as_ordered(x)

\method{as_ordered}{default}(x)
}
\arguments{
\item{x}{A vector of values}
}
\value{
An `ordered` vector
}
\description{
As ordered
}
\details{
Simple implementation of `ordered`.  If `x` is `ordered` it is
simply returned.  If `x` is a `factor` the `ordered` class is added.
Otherwise, `x` is made into a `factor` with [fact::fact()] and then the
`ordered` class is added. Unlike just `fact`, `ordered` will replace the `NA`
levels with `NA_integer_` to work appropriately with other functions.
}
\examples{
x <- c("a", NA, "b")
x <- fact(x)
str(x) # NA is 3L

y <- x
class(y) <- c("ordered", class(y))
max(y)
max(y, na.rm = TRUE) # returns NA -- bad

# as_ordered() removes the NA level
x <- as_ordered(x)
str(x)
max(x, na.rm = TRUE) # returns b -- correct
}
\seealso{
[fact()]

Other factors: 
\code{\link{drop_levels}()},
\code{\link{fact_na}()},
\code{\link{fact}()}
}
\concept{factors}
