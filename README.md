
<!-- README.md is generated from README.Rmd. Please edit that file -->

# facts

<!-- badges: start -->

[![R-CMD-check](https://github.com/jmbarbone/facts/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jmbarbone/facts/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/jmbarbone/facts/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jmbarbone/facts?branch=main)
[![Codecov test
coverage](https://codecov.io/gh/jmbarbone/facts/graph/badge.svg)](https://app.codecov.io/gh/jmbarbone/facts)
<!-- badges: end -->

The goal of facts is to simplify how the `factor` class is created,
modified, and coerced. `[base::factor()]` contains added sugar for
recoding values and managing multiple constraints. `facts()` takes a
simplified approach and moves these nice-to-haves to separate functions.

## Installation

You can install the development version of facts like so:

``` r
remotes::install_github("jmbarbone/facts")
```

## Creating facts

This is a basic example which shows you how to solve a common problem:

``` r
library(facts)
#> 
#> Attaching package: 'facts'
#> The following objects are masked from 'package:base':
#> 
#>     as.factor, as.ordered
```

A `facts` object looks very much like a `factor` object, with a few
differences.

``` r
f1 <- factor(c(1, NA))
f2 <- fact(c(1, NA))

f1
#> [1] 1    <NA>
#> Levels: 1
f2
#> [1]  1 NA
#> <double>: <NA> 1

str(f1)
#>  Factor w/ 1 level "1": 1 NA
str(f2)
#>  Factor w/ 2 levels NA,"1": 2 1
#>  - attr(*, "ptype")= num(0)

f2
#> [1]  1 NA
#> <double>: <NA> 1
levels(f2) <- c(1, "(null)")
f2
#> Warning in cast.double(levels(x), exattr(x, "ptype")): NAs introduced by
#> coercion
#> [1] NA  1
#> <double>: 1 (null)
```

In general, `factor()` will always sort `x` and by default doesn’t add
`NA` values to levels. `facts()`, however, will not sort character
vectors, will use a reverse sort of logical, sorts numeric accordingly,
and always includes `NA` labels when present in `x`.

``` r
x <- c("a", "c", NA, "a", "b", NA, "a", "c")
factor(x) # sorted, NA removed by default
#> [1] a    c    <NA> a    b    <NA> a    c   
#> Levels: a b c
fact(x)   # unsorted, NA retained by default
#> [1] a    c    <NA> a    b    <NA> a    c   
#> <character>: <NA> a c b

x <- c(-1, 5, 2, NA, 3)
factor(x) # sorted
#> [1] -1   5    2    <NA> 3   
#> Levels: -1 2 3 5
fact(x)   # sorted, but NA retained by default
#> [1] -1  5  2 NA  3
#> <double>: <NA> -1 2 3 5

x <- c(NA, FALSE, TRUE, FALSE, TRUE, NA)
factor(x)
#> [1] <NA>  FALSE TRUE  FALSE TRUE  <NA> 
#> Levels: FALSE TRUE
fact(x)   # Sorted TRUE, FALSE, NA
#> [1]    NA FALSE  TRUE FALSE  TRUE    NA
#> <logical>: <NA> FALSE TRUE
```

## Modifying facts

One benefit of `factor()` is that you can recode on the fly. This adds
additional overhead to the function because there is a necessity in
checking the `levels` and `labels` and matching up appropriate values.
The philosophy taken in `{facts}` is that the additional work of
modifying the object should take place prior to `facts()`. As such,
`recode()` is included, and can be used prior to `facts()` or after.

``` r
recode(fact(c(1, 1, 3, 0, 2)), 1 ~ -1, 2 ~ NA, .nomatch = "keep")
#> [1] -1 -1  3  0 NA
#> <double>: 0 -1 3
```
