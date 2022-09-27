
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fact

<!-- badges: start -->
<!-- badges: end -->

The goal of fact is to simplify how the `factor` class is created,
modified, and coerced. `[base::factor()]` contains added sugar for
recoding values and managing multiple constraints. `fact()` takes a
simplified approach and moves these nice-to-haves to separate functions.

## Todos

-   [ ] Use default `NA` label (`"(null)"`) or something
-   [ ] Be consistent about `values()`
-   [ ] Bench mark a bit more
-   [ ] Determine best way to adjust `values` (and `labels`) (e.g.,
    `values<-()`) and special cases of `range`
    -   `values(f, "levels") <- new_levels` for `character`
    -   `values(f, "range") <- values_range` for `integer` and `Date`
    -   `values(f, "levels", "remove") <- bad_values` for `character`
    -   `drop_levels(f)` for undoing these things
    -   `range_levels(f)` should add add a range for `integer` and
        `Date`

## Installation

You can install the development version of fact like so:

``` r
remotes::install_github("jmbarbone/fact")
```

## Creating facts

This is a basic example which shows you how to solve a common problem:

``` r
library(fact)
```

A `fact` object looks very much like a `factor` object, with a few
differences.

``` r
f1 <- factor(c(1, NA))
f2 <- fact(c(1, NA))
#> Registered S3 methods overwritten by 'mark':
#>   method            from
#>   [.fact            fact
#>   as.Date.fact      fact
#>   as.character.fact fact
#>   as.double.fact    fact
#>   as.integer.fact   fact
#>   print.fact        fact
#>   print.pseudo_id   fact
#>   unique.fact       fact

f1
#> [1] 1    <NA>
#> Levels: 1
f2
#> character(0)
#> Levels: 1 (na)

str(f1)
#>  Factor w/ 1 level "1": 1 NA
str(f2)
#>  Factor w/ 2 levels "1","(na)": 1 2
#>  - attr(*, "values")= num [1:2] 1 NA
#>  - attr(*, "na")= int 2

f2
#> character(0)
#> Levels: 1 (na)
levels(f2) <- c(1, "(null)")
f2
#> character(0)
#> Levels: 1 (null)
```

In general, `factor()` will always sort `x` and by default doesn’t add
`NA` values to levels. `fact()`, however, will not sort character
vectors, will use a reverse sort of logical, sorts numeric accordingly,
and always includes `NA` labels when present in `x`.

``` r
x <- c("a", "c", NA, "a", "b", NA, "a", "c")
factor(x) # sorted, NA removed by default
#> [1] a    c    <NA> a    b    <NA> a    c   
#> Levels: a b c
fact(x)   # unsorted, NA retained by default
#> character(0)
#> Levels: a c b (na)

x <- c(-1, 5, 2, NA, 3)
factor(x) # sorted
#> [1] -1   5    2    <NA> 3   
#> Levels: -1 2 3 5
fact(x)   # sorted, but NA retained by default
#> character(0)
#> Levels: -1 2 3 5 (na)

x <- c(NA, FALSE, TRUE, FALSE, TRUE, NA)
factor(x)
#> [1] <NA>  FALSE TRUE  FALSE TRUE  <NA> 
#> Levels: FALSE TRUE
fact(x)   # Sorted TRUE, FALSE, NA
#> character(0)
#> Levels: TRUE FALSE (na)
```

## Modifying facts

One benefit of `factor()` is that you an recode on the fly. This adds
additional overhead to the function because there is a necessity in
checking the `levels` and `labels` and matching up appropriate values.
The philosophy taken in `{fact}` is that the additional work of
modifying the object should take place prior to `fact()`. However, some
cases, these sort of manipulations can benefit from reducing the number
of unique values.

``` r
x <- c("blue", "green", "red", "purple", "black", "white")
x <- sample(x, 100, TRUE)
id <- pseudo_id(x)
id
#>   [1] 1 2 3 4 3 1 3 2 3 4 1 5 4 3 2 4 1 6 5 6 6 2 3 2 1 2 1 1 3 1 4 1 1 4 4 5 2
#>  [38] 2 4 1 4 3 5 2 4 1 1 1 1 4 2 5 2 2 3 3 6 1 3 6 3 5 4 3 2 5 6 3 4 2 5 1 4 2
#>  [75] 5 3 1 1 3 4 5 1 1 6 4 6 2 3 3 5 4 2 1 4 2 2 3 1 3 2
#> Uniques:
```
