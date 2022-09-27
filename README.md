
<!-- README.md is generated from README.Rmd. Please edit that file -->

# facts

<!-- badges: start -->
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
```

A `facts` object looks very much like a `factor` object, with a few
differences.

``` r
f1 <- factor(c(1, NA))
f2 <- facts(c(1, NA))
#> Registered S3 method overwritten by 'mark':
#>   method          from 
#>   print.pseudo_id facts

f1
#> [1] 1    <NA>
#> Levels: 1
f2
#> [1] 1    <NA>
#> levels: 1 (na)

str(f1)
#>  Factor w/ 1 level "1": 1 NA
str(f2)
#>  Factor w/ 2 levels "1","(na)": 1 2
#>  - attr(*, "values")= num [1:2] 1 NA
#>  - attr(*, "na")= int 2

f2
#> [1] 1    <NA>
#> levels: 1 (na)
levels(f2) <- c(1, "(null)")
f2
#> [1] 1    <NA>
#> levels: 1 (null)
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
facts(x)   # unsorted, NA retained by default
#> [1] a    c    <NA> a    b    <NA> a    c   
#> levels: a c b (na)

x <- c(-1, 5, 2, NA, 3)
factor(x) # sorted
#> [1] -1   5    2    <NA> 3   
#> Levels: -1 2 3 5
facts(x)   # sorted, but NA retained by default
#> [1] -1   5    2    <NA> 3   
#> levels: -1 2 3 5 (na)

x <- c(NA, FALSE, TRUE, FALSE, TRUE, NA)
factor(x)
#> [1] <NA>  FALSE TRUE  FALSE TRUE  <NA> 
#> Levels: FALSE TRUE
facts(x)   # Sorted TRUE, FALSE, NA
#> [1] <NA>  FALSE TRUE  FALSE TRUE  <NA> 
#> levels: TRUE FALSE (na)
```

## Modifying facts

One benefit of `factor()` is that you an recode on the fly. This adds
additional overhead to the function because there is a necessity in
checking the `levels` and `labels` and matching up appropriate values.
The philosophy taken in `{facts}` is that the additional work of
modifying the object should take place prior to `facts()`. However, some
cases, these sort of manipulations can benefit from reducing the number
of unique values.

``` r
x <- c("blue", "green", "red", "purple", "black", "white")
x <- sample(x, 100, TRUE)
id <- pseudo_id(x)
id
#>   [1] 1 2 3 3 4 5 1 3 2 3 2 2 4 1 1 3 2 4 6 5 1 3 5 5 5 6 4 2 6 2 5 5 5 2 1 2 6
#>  [38] 3 6 4 1 2 3 2 6 1 6 2 3 3 3 3 3 4 2 4 4 4 2 2 5 2 3 2 2 6 1 1 1 1 4 6 6 2
#>  [75] 2 3 4 1 6 5 5 6 1 2 6 4 4 1 1 5 4 3 1 4 4 5 3 4 2 6
#> Uniques:
```
