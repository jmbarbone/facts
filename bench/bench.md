
<!-- bench/bench.md is generated from bench/bench.Rmd. Please edit that file -->

``` r
library(facts)
```

``` r
# to save these
bench_env <- new.env()

do_bench <- function(
    unique_n = 10^(1:4), 
    values_n = 10^(2:6), 
    values_type = c("logical", "character", "double", "integer", "date")
) {
  values_type <- match.arg(values_type)
  
  if (values_type == "logical") {
    unique_n <- 3
  }
  
  res <- bench::press(
    un = unique_n,
    vn = values_n,
    {
      x <- switch(
        values_type,
        character = stringi::stri_rand_strings(un, 5),
        double = runif(un),
        integer = order(runif(un)),
        date = Sys.Date() + order(runif(un)),
        logical = c(TRUE, FALSE, NA)
      )
      x <- sample(x, vn, TRUE)
      bench::mark(
        factor = factor(x),
        fact = fact(x),
        check = FALSE
      )
    }
  )
  
  assign(values_type, res, envir = bench_env)
  
  print(bench:::autoplot.bench_mark(res) + ggplot2::theme(legend.position = "top"))
  
  writeLines('<details><summary>Show table</summary>')
  res[1:9] |>
    transform(expression = sapply(expression, deparse)) |>
    gt::gt("expression") |> 
    print()
  writeLines("</details>")
  
  invisible()
}
```

## Other vector types

``` r
res <- bench::press(
  n_unique = 10^(1:4),
  n_values = 10^(2:6),
  value_type = c("character", "double", "integer", "date"),
  {
    x <- switch(
      value_type,
      character = stringi::stri_rand_strings(n_unique, 5),
      double = runif(n_unique),
      integer = order(runif(n_unique)),
      date = Sys.Date() + order(runif(n_unique))
    )
    x <- sample(x, n_values, TRUE)
    bench::mark(
      factor = factor(x),
      fact = fact(x),
      check = FALSE
    )
  }
)
#> Running with:
#>    n_unique n_values value_type
#>  1       10      100 character
#>  2      100      100 character
#>  3     1000      100 character
#>  4    10000      100 character
#>  5       10     1000 character
#>  6      100     1000 character
#>  7     1000     1000 character
#>  8    10000     1000 character
#>  9       10    10000 character
#> 10      100    10000 character
#> 11     1000    10000 character
#> 12    10000    10000 character
#> 13       10   100000 character
#> 14      100   100000 character
#> 15     1000   100000 character
#> 16    10000   100000 character
#> 17       10  1000000 character
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 18      100  1000000 character
#> 19     1000  1000000 character
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 20    10000  1000000 character
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 21       10      100 double
#> 22      100      100 double
#> 23     1000      100 double
#> 24    10000      100 double
#> 25       10     1000 double
#> 26      100     1000 double
#> 27     1000     1000 double
#> 28    10000     1000 double
#> 29       10    10000 double
#> 30      100    10000 double
#> 31     1000    10000 double
#> 32    10000    10000 double
#> 33       10   100000 double
#> 34      100   100000 double
#> 35     1000   100000 double
#> 36    10000   100000 double
#> 37       10  1000000 double
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 38      100  1000000 double
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 39     1000  1000000 double
#> 40    10000  1000000 double
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 41       10      100 integer
#> 42      100      100 integer
#> 43     1000      100 integer
#> 44    10000      100 integer
#> 45       10     1000 integer
#> 46      100     1000 integer
#> 47     1000     1000 integer
#> 48    10000     1000 integer
#> 49       10    10000 integer
#> 50      100    10000 integer
#> 51     1000    10000 integer
#> 52    10000    10000 integer
#> 53       10   100000 integer
#> 54      100   100000 integer
#> 55     1000   100000 integer
#> 56    10000   100000 integer
#> 57       10  1000000 integer
#> 58      100  1000000 integer
#> 59     1000  1000000 integer
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 60    10000  1000000 integer
#> 61       10      100 date
#> 62      100      100 date
#> 63     1000      100 date
#> 64    10000      100 date
#> 65       10     1000 date
#> 66      100     1000 date
#> 67     1000     1000 date
#> 68    10000     1000 date
#> 69       10    10000 date
#> 70      100    10000 date
#> 71     1000    10000 date
#> 72    10000    10000 date
#> 73       10   100000 date
#> 74      100   100000 date
#> 75     1000   100000 date
#> 76    10000   100000 date
#> 77       10  1000000 date
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 78      100  1000000 date
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 79     1000  1000000 date
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> 80    10000  1000000 date
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
```

``` r
res[1:9] |> 
  transform(expression = sapply(expression, deparse1)) |> 
  gt::gt("expression", "value_type") |> 
  gt::tab_options(row.striping.include_table_body = TRUE)
```

<div id="rnovrxbqnh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#rnovrxbqnh .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#rnovrxbqnh .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rnovrxbqnh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rnovrxbqnh .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rnovrxbqnh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rnovrxbqnh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rnovrxbqnh .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rnovrxbqnh .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#rnovrxbqnh .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#rnovrxbqnh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rnovrxbqnh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rnovrxbqnh .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#rnovrxbqnh .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#rnovrxbqnh .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#rnovrxbqnh .gt_from_md > :first-child {
  margin-top: 0;
}

#rnovrxbqnh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rnovrxbqnh .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#rnovrxbqnh .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#rnovrxbqnh .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#rnovrxbqnh .gt_row_group_first td {
  border-top-width: 2px;
}

#rnovrxbqnh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnovrxbqnh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rnovrxbqnh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rnovrxbqnh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rnovrxbqnh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnovrxbqnh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rnovrxbqnh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rnovrxbqnh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rnovrxbqnh .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rnovrxbqnh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnovrxbqnh .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rnovrxbqnh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnovrxbqnh .gt_left {
  text-align: left;
}

#rnovrxbqnh .gt_center {
  text-align: center;
}

#rnovrxbqnh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rnovrxbqnh .gt_font_normal {
  font-weight: normal;
}

#rnovrxbqnh .gt_font_bold {
  font-weight: bold;
}

#rnovrxbqnh .gt_font_italic {
  font-style: italic;
}

#rnovrxbqnh .gt_super {
  font-size: 65%;
}

#rnovrxbqnh .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#rnovrxbqnh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rnovrxbqnh .gt_indent_1 {
  text-indent: 5px;
}

#rnovrxbqnh .gt_indent_2 {
  text-indent: 10px;
}

#rnovrxbqnh .gt_indent_3 {
  text-indent: 15px;
}

#rnovrxbqnh .gt_indent_4 {
  text-indent: 20px;
}

#rnovrxbqnh .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id=""></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="n_unique">n_unique</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="n_values">n_values</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="min">min</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="median">median</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="itr.sec">itr.sec</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="mem_alloc">mem_alloc</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="gc.sec">gc.sec</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <th colspan="8" class="gt_group_heading" scope="colgroup" id="character">character</th>
    </tr>
    <tr class="gt_row_group_first"><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_1 n_unique" class="gt_row gt_right">10</td>
<td headers="character stub_1_1 n_values" class="gt_row gt_right">1e+02</td>
<td headers="character stub_1_1 min" class="gt_row gt_center">31.07µs</td>
<td headers="character stub_1_1 median" class="gt_row gt_center">37.84µs</td>
<td headers="character stub_1_1 itr.sec" class="gt_row gt_right">2.417902e+04</td>
<td headers="character stub_1_1 mem_alloc" class="gt_row gt_center">2.75KB</td>
<td headers="character stub_1_1 gc.sec" class="gt_row gt_right">9.675480</td></tr>
    <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_2 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="character stub_1_2 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="character stub_1_2 min" class="gt_row gt_center gt_striped">59.43µs</td>
<td headers="character stub_1_2 median" class="gt_row gt_center gt_striped">69.77µs</td>
<td headers="character stub_1_2 itr.sec" class="gt_row gt_right gt_striped">1.304838e+04</td>
<td headers="character stub_1_2 mem_alloc" class="gt_row gt_center gt_striped">152.56KB</td>
<td headers="character stub_1_2 gc.sec" class="gt_row gt_right gt_striped">8.315040</td></tr>
    <tr><th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_3 n_unique" class="gt_row gt_right">100</td>
<td headers="character stub_1_3 n_values" class="gt_row gt_right">1e+02</td>
<td headers="character stub_1_3 min" class="gt_row gt_center">66.51µs</td>
<td headers="character stub_1_3 median" class="gt_row gt_center">78.94µs</td>
<td headers="character stub_1_3 itr.sec" class="gt_row gt_right">1.162284e+04</td>
<td headers="character stub_1_3 mem_alloc" class="gt_row gt_center">9.04KB</td>
<td headers="character stub_1_3 gc.sec" class="gt_row gt_right">6.265680</td></tr>
    <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_4 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="character stub_1_4 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="character stub_1_4 min" class="gt_row gt_center gt_striped">60.46µs</td>
<td headers="character stub_1_4 median" class="gt_row gt_center gt_striped">71.01µs</td>
<td headers="character stub_1_4 itr.sec" class="gt_row gt_right gt_striped">1.287576e+04</td>
<td headers="character stub_1_4 mem_alloc" class="gt_row gt_center gt_striped">4.76KB</td>
<td headers="character stub_1_4 gc.sec" class="gt_row gt_right gt_striped">8.375838</td></tr>
    <tr><th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_5 n_unique" class="gt_row gt_right">1000</td>
<td headers="character stub_1_5 n_values" class="gt_row gt_right">1e+02</td>
<td headers="character stub_1_5 min" class="gt_row gt_center">93.59µs</td>
<td headers="character stub_1_5 median" class="gt_row gt_center">108.07µs</td>
<td headers="character stub_1_5 itr.sec" class="gt_row gt_right">8.246577e+03</td>
<td headers="character stub_1_5 mem_alloc" class="gt_row gt_center">13.02KB</td>
<td headers="character stub_1_5 gc.sec" class="gt_row gt_right">2.033180</td></tr>
    <tr><th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_6 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="character stub_1_6 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="character stub_1_6 min" class="gt_row gt_center gt_striped">62.05µs</td>
<td headers="character stub_1_6 median" class="gt_row gt_center gt_striped">73.20µs</td>
<td headers="character stub_1_6 itr.sec" class="gt_row gt_right gt_striped">1.245573e+04</td>
<td headers="character stub_1_6 mem_alloc" class="gt_row gt_center gt_striped">5.71KB</td>
<td headers="character stub_1_6 gc.sec" class="gt_row gt_right gt_striped">8.363763</td></tr>
    <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_7 n_unique" class="gt_row gt_right">10000</td>
<td headers="character stub_1_7 n_values" class="gt_row gt_right">1e+02</td>
<td headers="character stub_1_7 min" class="gt_row gt_center">101.75µs</td>
<td headers="character stub_1_7 median" class="gt_row gt_center">120.03µs</td>
<td headers="character stub_1_7 itr.sec" class="gt_row gt_right">7.616533e+03</td>
<td headers="character stub_1_7 mem_alloc" class="gt_row gt_center">13.49KB</td>
<td headers="character stub_1_7 gc.sec" class="gt_row gt_right">4.159767</td></tr>
    <tr><th id="stub_1_8" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_8 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="character stub_1_8 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="character stub_1_8 min" class="gt_row gt_center gt_striped">61.66µs</td>
<td headers="character stub_1_8 median" class="gt_row gt_center gt_striped">71.99µs</td>
<td headers="character stub_1_8 itr.sec" class="gt_row gt_right gt_striped">1.269909e+04</td>
<td headers="character stub_1_8 mem_alloc" class="gt_row gt_center gt_striped">6.41KB</td>
<td headers="character stub_1_8 gc.sec" class="gt_row gt_right gt_striped">8.362914</td></tr>
    <tr><th id="stub_1_9" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_9 n_unique" class="gt_row gt_right">10</td>
<td headers="character stub_1_9 n_values" class="gt_row gt_right">1e+03</td>
<td headers="character stub_1_9 min" class="gt_row gt_center">60.04µs</td>
<td headers="character stub_1_9 median" class="gt_row gt_center">71.65µs</td>
<td headers="character stub_1_9 itr.sec" class="gt_row gt_right">1.276477e+04</td>
<td headers="character stub_1_9 mem_alloc" class="gt_row gt_center">23.81KB</td>
<td headers="character stub_1_9 gc.sec" class="gt_row gt_right">6.173517</td></tr>
    <tr><th id="stub_1_10" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_10 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="character stub_1_10 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="character stub_1_10 min" class="gt_row gt_center gt_striped">82.69µs</td>
<td headers="character stub_1_10 median" class="gt_row gt_center gt_striped">98.06µs</td>
<td headers="character stub_1_10 itr.sec" class="gt_row gt_right gt_striped">9.475772e+03</td>
<td headers="character stub_1_10 mem_alloc" class="gt_row gt_center gt_striped">19.91KB</td>
<td headers="character stub_1_10 gc.sec" class="gt_row gt_right gt_striped">6.171801</td></tr>
    <tr><th id="stub_1_11" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_11 n_unique" class="gt_row gt_right">100</td>
<td headers="character stub_1_11 n_values" class="gt_row gt_right">1e+03</td>
<td headers="character stub_1_11 min" class="gt_row gt_center">121.49µs</td>
<td headers="character stub_1_11 median" class="gt_row gt_center">147.00µs</td>
<td headers="character stub_1_11 itr.sec" class="gt_row gt_right">6.329401e+03</td>
<td headers="character stub_1_11 mem_alloc" class="gt_row gt_center">34.55KB</td>
<td headers="character stub_1_11 gc.sec" class="gt_row gt_right">4.103339</td></tr>
    <tr><th id="stub_1_12" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_12 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="character stub_1_12 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="character stub_1_12 min" class="gt_row gt_center gt_striped">82.15µs</td>
<td headers="character stub_1_12 median" class="gt_row gt_center gt_striped">99.72µs</td>
<td headers="character stub_1_12 itr.sec" class="gt_row gt_right gt_striped">9.297161e+03</td>
<td headers="character stub_1_12 mem_alloc" class="gt_row gt_center gt_striped">23.95KB</td>
<td headers="character stub_1_12 gc.sec" class="gt_row gt_right gt_striped">6.235521</td></tr>
    <tr><th id="stub_1_13" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_13 n_unique" class="gt_row gt_right">1000</td>
<td headers="character stub_1_13 n_values" class="gt_row gt_right">1e+03</td>
<td headers="character stub_1_13 min" class="gt_row gt_center">824.64µs</td>
<td headers="character stub_1_13 median" class="gt_row gt_center">993.55µs</td>
<td headers="character stub_1_13 itr.sec" class="gt_row gt_right">9.589826e+02</td>
<td headers="character stub_1_13 mem_alloc" class="gt_row gt_center">93.10KB</td>
<td headers="character stub_1_13 gc.sec" class="gt_row gt_right">2.023170</td></tr>
    <tr><th id="stub_1_14" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_14 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="character stub_1_14 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="character stub_1_14 min" class="gt_row gt_center gt_striped">112.99µs</td>
<td headers="character stub_1_14 median" class="gt_row gt_center gt_striped">134.60µs</td>
<td headers="character stub_1_14 itr.sec" class="gt_row gt_right gt_striped">6.901830e+03</td>
<td headers="character stub_1_14 mem_alloc" class="gt_row gt_center gt_striped">41.55KB</td>
<td headers="character stub_1_14 gc.sec" class="gt_row gt_right gt_striped">6.199248</td></tr>
    <tr><th id="stub_1_15" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_15 n_unique" class="gt_row gt_right">10000</td>
<td headers="character stub_1_15 n_values" class="gt_row gt_right">1e+03</td>
<td headers="character stub_1_15 min" class="gt_row gt_center">1.39ms</td>
<td headers="character stub_1_15 median" class="gt_row gt_center">1.67ms</td>
<td headers="character stub_1_15 itr.sec" class="gt_row gt_right">5.699103e+02</td>
<td headers="character stub_1_15 mem_alloc" class="gt_row gt_center">114.48KB</td>
<td headers="character stub_1_15 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_16" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_16 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="character stub_1_16 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="character stub_1_16 min" class="gt_row gt_center gt_striped">114.66µs</td>
<td headers="character stub_1_16 median" class="gt_row gt_center gt_striped">138.94µs</td>
<td headers="character stub_1_16 itr.sec" class="gt_row gt_right gt_striped">6.705779e+03</td>
<td headers="character stub_1_16 mem_alloc" class="gt_row gt_center gt_striped">53.87KB</td>
<td headers="character stub_1_16 gc.sec" class="gt_row gt_right gt_striped">8.461551</td></tr>
    <tr><th id="stub_1_17" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_17 n_unique" class="gt_row gt_right">10</td>
<td headers="character stub_1_17 n_values" class="gt_row gt_right">1e+04</td>
<td headers="character stub_1_17 min" class="gt_row gt_center">372.94µs</td>
<td headers="character stub_1_17 median" class="gt_row gt_center">459.87µs</td>
<td headers="character stub_1_17 itr.sec" class="gt_row gt_right">2.072841e+03</td>
<td headers="character stub_1_17 mem_alloc" class="gt_row gt_center">284.44KB</td>
<td headers="character stub_1_17 gc.sec" class="gt_row gt_right">12.808494</td></tr>
    <tr><th id="stub_1_18" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_18 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="character stub_1_18 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="character stub_1_18 min" class="gt_row gt_center gt_striped">334.69µs</td>
<td headers="character stub_1_18 median" class="gt_row gt_center gt_striped">408.36µs</td>
<td headers="character stub_1_18 itr.sec" class="gt_row gt_right gt_striped">2.303691e+03</td>
<td headers="character stub_1_18 mem_alloc" class="gt_row gt_center gt_striped">245.38KB</td>
<td headers="character stub_1_18 gc.sec" class="gt_row gt_right gt_striped">10.480852</td></tr>
    <tr><th id="stub_1_19" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_19 n_unique" class="gt_row gt_right">100</td>
<td headers="character stub_1_19 n_values" class="gt_row gt_right">1e+04</td>
<td headers="character stub_1_19 min" class="gt_row gt_center">701.65µs</td>
<td headers="character stub_1_19 median" class="gt_row gt_center">859.07µs</td>
<td headers="character stub_1_19 itr.sec" class="gt_row gt_right">1.121793e+03</td>
<td headers="character stub_1_19 mem_alloc" class="gt_row gt_center">295.18KB</td>
<td headers="character stub_1_19 gc.sec" class="gt_row gt_right">8.340471</td></tr>
    <tr><th id="stub_1_20" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_20 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="character stub_1_20 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="character stub_1_20 min" class="gt_row gt_center gt_striped">281.59µs</td>
<td headers="character stub_1_20 median" class="gt_row gt_center gt_striped">345.67µs</td>
<td headers="character stub_1_20 itr.sec" class="gt_row gt_right gt_striped">2.730255e+03</td>
<td headers="character stub_1_20 mem_alloc" class="gt_row gt_center gt_striped">249.42KB</td>
<td headers="character stub_1_20 gc.sec" class="gt_row gt_right gt_striped">12.669396</td></tr>
    <tr><th id="stub_1_21" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_21 n_unique" class="gt_row gt_right">1000</td>
<td headers="character stub_1_21 n_values" class="gt_row gt_right">1e+04</td>
<td headers="character stub_1_21 min" class="gt_row gt_center">1.66ms</td>
<td headers="character stub_1_21 median" class="gt_row gt_center">2.05ms</td>
<td headers="character stub_1_21 itr.sec" class="gt_row gt_right">4.780539e+02</td>
<td headers="character stub_1_21 mem_alloc" class="gt_row gt_center">379.46KB</td>
<td headers="character stub_1_21 gc.sec" class="gt_row gt_right">4.085931</td></tr>
    <tr><th id="stub_1_22" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_22 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="character stub_1_22 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="character stub_1_22 min" class="gt_row gt_center gt_striped">352.88µs</td>
<td headers="character stub_1_22 median" class="gt_row gt_center gt_striped">437.77µs</td>
<td headers="character stub_1_22 itr.sec" class="gt_row gt_right gt_striped">2.167254e+03</td>
<td headers="character stub_1_22 mem_alloc" class="gt_row gt_center gt_striped">281.03KB</td>
<td headers="character stub_1_22 gc.sec" class="gt_row gt_right gt_striped">12.798743</td></tr>
    <tr><th id="stub_1_23" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_23 n_unique" class="gt_row gt_right">10000</td>
<td headers="character stub_1_23 n_values" class="gt_row gt_right">1e+04</td>
<td headers="character stub_1_23 min" class="gt_row gt_center">14.48ms</td>
<td headers="character stub_1_23 median" class="gt_row gt_center">17.21ms</td>
<td headers="character stub_1_23 itr.sec" class="gt_row gt_right">5.840553e+01</td>
<td headers="character stub_1_23 mem_alloc" class="gt_row gt_center">920.77KB</td>
<td headers="character stub_1_23 gc.sec" class="gt_row gt_right">2.085912</td></tr>
    <tr><th id="stub_1_24" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_24 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="character stub_1_24 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="character stub_1_24 min" class="gt_row gt_center gt_striped">534.35µs</td>
<td headers="character stub_1_24 median" class="gt_row gt_center gt_striped">648.67µs</td>
<td headers="character stub_1_24 itr.sec" class="gt_row gt_right gt_striped">1.486806e+03</td>
<td headers="character stub_1_24 mem_alloc" class="gt_row gt_center gt_striped">482.19KB</td>
<td headers="character stub_1_24 gc.sec" class="gt_row gt_right gt_striped">14.975021</td></tr>
    <tr><th id="stub_1_25" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_25 n_unique" class="gt_row gt_right">10</td>
<td headers="character stub_1_25 n_values" class="gt_row gt_right">1e+05</td>
<td headers="character stub_1_25 min" class="gt_row gt_center">2.74ms</td>
<td headers="character stub_1_25 median" class="gt_row gt_center">3.43ms</td>
<td headers="character stub_1_25 itr.sec" class="gt_row gt_right">2.856416e+02</td>
<td headers="character stub_1_25 mem_alloc" class="gt_row gt_center">2.53MB</td>
<td headers="character stub_1_25 gc.sec" class="gt_row gt_right">15.868976</td></tr>
    <tr><th id="stub_1_26" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_26 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="character stub_1_26 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="character stub_1_26 min" class="gt_row gt_center gt_striped">2.70ms</td>
<td headers="character stub_1_26 median" class="gt_row gt_center gt_striped">3.17ms</td>
<td headers="character stub_1_26 itr.sec" class="gt_row gt_right gt_striped">3.020101e+02</td>
<td headers="character stub_1_26 mem_alloc" class="gt_row gt_center gt_striped">2.15MB</td>
<td headers="character stub_1_26 gc.sec" class="gt_row gt_right gt_striped">15.659784</td></tr>
    <tr><th id="stub_1_27" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_27 n_unique" class="gt_row gt_right">100</td>
<td headers="character stub_1_27 n_values" class="gt_row gt_right">1e+05</td>
<td headers="character stub_1_27 min" class="gt_row gt_center">3.67ms</td>
<td headers="character stub_1_27 median" class="gt_row gt_center">4.30ms</td>
<td headers="character stub_1_27 itr.sec" class="gt_row gt_right">2.242824e+02</td>
<td headers="character stub_1_27 mem_alloc" class="gt_row gt_center">2.54MB</td>
<td headers="character stub_1_27 gc.sec" class="gt_row gt_right">15.544322</td></tr>
    <tr><th id="stub_1_28" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_28 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="character stub_1_28 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="character stub_1_28 min" class="gt_row gt_center gt_striped">2.45ms</td>
<td headers="character stub_1_28 median" class="gt_row gt_center gt_striped">2.92ms</td>
<td headers="character stub_1_28 itr.sec" class="gt_row gt_right gt_striped">3.306327e+02</td>
<td headers="character stub_1_28 mem_alloc" class="gt_row gt_center gt_striped">2.15MB</td>
<td headers="character stub_1_28 gc.sec" class="gt_row gt_right gt_striped">15.429525</td></tr>
    <tr><th id="stub_1_29" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_29 n_unique" class="gt_row gt_right">1000</td>
<td headers="character stub_1_29 n_values" class="gt_row gt_right">1e+05</td>
<td headers="character stub_1_29 min" class="gt_row gt_center">3.90ms</td>
<td headers="character stub_1_29 median" class="gt_row gt_center">4.79ms</td>
<td headers="character stub_1_29 itr.sec" class="gt_row gt_right">2.080773e+02</td>
<td headers="character stub_1_29 mem_alloc" class="gt_row gt_center">2.62MB</td>
<td headers="character stub_1_29 gc.sec" class="gt_row gt_right">13.281531</td></tr>
    <tr><th id="stub_1_30" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_30 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="character stub_1_30 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="character stub_1_30 min" class="gt_row gt_center gt_striped">2.72ms</td>
<td headers="character stub_1_30 median" class="gt_row gt_center gt_striped">3.24ms</td>
<td headers="character stub_1_30 itr.sec" class="gt_row gt_right gt_striped">2.994541e+02</td>
<td headers="character stub_1_30 mem_alloc" class="gt_row gt_center gt_striped">2.18MB</td>
<td headers="character stub_1_30 gc.sec" class="gt_row gt_right gt_striped">17.877856</td></tr>
    <tr><th id="stub_1_31" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_31 n_unique" class="gt_row gt_right">10000</td>
<td headers="character stub_1_31 n_values" class="gt_row gt_right">1e+05</td>
<td headers="character stub_1_31 min" class="gt_row gt_center">27.28ms</td>
<td headers="character stub_1_31 median" class="gt_row gt_center">32.15ms</td>
<td headers="character stub_1_31 itr.sec" class="gt_row gt_right">3.134839e+01</td>
<td headers="character stub_1_31 mem_alloc" class="gt_row gt_center">3.59MB</td>
<td headers="character stub_1_31 gc.sec" class="gt_row gt_right">2.089893</td></tr>
    <tr><th id="stub_1_32" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_32 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="character stub_1_32 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="character stub_1_32 min" class="gt_row gt_center gt_striped">4.01ms</td>
<td headers="character stub_1_32 median" class="gt_row gt_center gt_striped">4.84ms</td>
<td headers="character stub_1_32 itr.sec" class="gt_row gt_right gt_striped">1.998011e+02</td>
<td headers="character stub_1_32 mem_alloc" class="gt_row gt_center gt_striped">2.47MB</td>
<td headers="character stub_1_32 gc.sec" class="gt_row gt_right gt_striped">13.320077</td></tr>
    <tr><th id="stub_1_33" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_33 n_unique" class="gt_row gt_right">10</td>
<td headers="character stub_1_33 n_values" class="gt_row gt_right">1e+06</td>
<td headers="character stub_1_33 min" class="gt_row gt_center">40.59ms</td>
<td headers="character stub_1_33 median" class="gt_row gt_center">44.84ms</td>
<td headers="character stub_1_33 itr.sec" class="gt_row gt_right">1.877301e+01</td>
<td headers="character stub_1_33 mem_alloc" class="gt_row gt_center">23.26MB</td>
<td headers="character stub_1_33 gc.sec" class="gt_row gt_right">22.186286</td></tr>
    <tr><th id="stub_1_34" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_34 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="character stub_1_34 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="character stub_1_34 min" class="gt_row gt_center gt_striped">23.87ms</td>
<td headers="character stub_1_34 median" class="gt_row gt_center gt_striped">29.00ms</td>
<td headers="character stub_1_34 itr.sec" class="gt_row gt_right gt_striped">3.386817e+01</td>
<td headers="character stub_1_34 mem_alloc" class="gt_row gt_center gt_striped">19.44MB</td>
<td headers="character stub_1_34 gc.sec" class="gt_row gt_right gt_striped">15.937962</td></tr>
    <tr><th id="stub_1_35" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_35 n_unique" class="gt_row gt_right">100</td>
<td headers="character stub_1_35 n_values" class="gt_row gt_right">1e+06</td>
<td headers="character stub_1_35 min" class="gt_row gt_center">30.79ms</td>
<td headers="character stub_1_35 median" class="gt_row gt_center">30.79ms</td>
<td headers="character stub_1_35 itr.sec" class="gt_row gt_right">3.248203e+01</td>
<td headers="character stub_1_35 mem_alloc" class="gt_row gt_center">23.27MB</td>
<td headers="character stub_1_35 gc.sec" class="gt_row gt_right">454.748379</td></tr>
    <tr><th id="stub_1_36" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_36 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="character stub_1_36 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="character stub_1_36 min" class="gt_row gt_center gt_striped">26.69ms</td>
<td headers="character stub_1_36 median" class="gt_row gt_center gt_striped">29.07ms</td>
<td headers="character stub_1_36 itr.sec" class="gt_row gt_right gt_striped">3.421675e+01</td>
<td headers="character stub_1_36 mem_alloc" class="gt_row gt_center gt_striped">19.45MB</td>
<td headers="character stub_1_36 gc.sec" class="gt_row gt_right gt_striped">43.992965</td></tr>
    <tr><th id="stub_1_37" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_37 n_unique" class="gt_row gt_right">1000</td>
<td headers="character stub_1_37 n_values" class="gt_row gt_right">1e+06</td>
<td headers="character stub_1_37 min" class="gt_row gt_center">35.53ms</td>
<td headers="character stub_1_37 median" class="gt_row gt_center">39.18ms</td>
<td headers="character stub_1_37 itr.sec" class="gt_row gt_right">2.550440e+01</td>
<td headers="character stub_1_37 mem_alloc" class="gt_row gt_center">23.35MB</td>
<td headers="character stub_1_37 gc.sec" class="gt_row gt_right">25.504397</td></tr>
    <tr><th id="stub_1_38" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_38 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="character stub_1_38 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="character stub_1_38 min" class="gt_row gt_center gt_striped">27.76ms</td>
<td headers="character stub_1_38 median" class="gt_row gt_center gt_striped">36.11ms</td>
<td headers="character stub_1_38 itr.sec" class="gt_row gt_right gt_striped">2.928747e+01</td>
<td headers="character stub_1_38 mem_alloc" class="gt_row gt_center gt_striped">19.48MB</td>
<td headers="character stub_1_38 gc.sec" class="gt_row gt_right gt_striped">17.572482</td></tr>
    <tr><th id="stub_1_39" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="character stub_1_39 n_unique" class="gt_row gt_right">10000</td>
<td headers="character stub_1_39 n_values" class="gt_row gt_right">1e+06</td>
<td headers="character stub_1_39 min" class="gt_row gt_center">64.83ms</td>
<td headers="character stub_1_39 median" class="gt_row gt_center">70.70ms</td>
<td headers="character stub_1_39 itr.sec" class="gt_row gt_right">1.393571e+01</td>
<td headers="character stub_1_39 mem_alloc" class="gt_row gt_center">24.32MB</td>
<td headers="character stub_1_39 gc.sec" class="gt_row gt_right">13.935713</td></tr>
    <tr><th id="stub_1_40" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="character stub_1_40 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="character stub_1_40 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="character stub_1_40 min" class="gt_row gt_center gt_striped">49.76ms</td>
<td headers="character stub_1_40 median" class="gt_row gt_center gt_striped">53.35ms</td>
<td headers="character stub_1_40 itr.sec" class="gt_row gt_right gt_striped">1.588357e+01</td>
<td headers="character stub_1_40 mem_alloc" class="gt_row gt_center gt_striped">19.77MB</td>
<td headers="character stub_1_40 gc.sec" class="gt_row gt_right gt_striped">13.898120</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="8" class="gt_group_heading" scope="colgroup" id="double">double</th>
    </tr>
    <tr class="gt_row_group_first"><th id="stub_1_41" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_41 n_unique" class="gt_row gt_right">10</td>
<td headers="double stub_1_41 n_values" class="gt_row gt_right">1e+02</td>
<td headers="double stub_1_41 min" class="gt_row gt_center">110.17µs</td>
<td headers="double stub_1_41 median" class="gt_row gt_center">130.32µs</td>
<td headers="double stub_1_41 itr.sec" class="gt_row gt_right">7.086653e+03</td>
<td headers="double stub_1_41 mem_alloc" class="gt_row gt_center">3.58KB</td>
<td headers="double stub_1_41 gc.sec" class="gt_row gt_right">2.018414</td></tr>
    <tr><th id="stub_1_42" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_42 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="double stub_1_42 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="double stub_1_42 min" class="gt_row gt_center gt_striped">69.12µs</td>
<td headers="double stub_1_42 median" class="gt_row gt_center gt_striped">81.20µs</td>
<td headers="double stub_1_42 itr.sec" class="gt_row gt_right gt_striped">1.136954e+04</td>
<td headers="double stub_1_42 mem_alloc" class="gt_row gt_center gt_striped">72.56KB</td>
<td headers="double stub_1_42 gc.sec" class="gt_row gt_right gt_striped">8.315623</td></tr>
    <tr><th id="stub_1_43" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_43 n_unique" class="gt_row gt_right">100</td>
<td headers="double stub_1_43 n_values" class="gt_row gt_right">1e+02</td>
<td headers="double stub_1_43 min" class="gt_row gt_center">155.98µs</td>
<td headers="double stub_1_43 median" class="gt_row gt_center">182.24µs</td>
<td headers="double stub_1_43 itr.sec" class="gt_row gt_right">5.115243e+03</td>
<td headers="double stub_1_43 mem_alloc" class="gt_row gt_center">10.77KB</td>
<td headers="double stub_1_43 gc.sec" class="gt_row gt_right">2.027445</td></tr>
    <tr><th id="stub_1_44" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_44 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="double stub_1_44 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="double stub_1_44 min" class="gt_row gt_center gt_striped">72.03µs</td>
<td headers="double stub_1_44 median" class="gt_row gt_center gt_striped">85.03µs</td>
<td headers="double stub_1_44 itr.sec" class="gt_row gt_right gt_striped">1.102767e+04</td>
<td headers="double stub_1_44 mem_alloc" class="gt_row gt_center gt_striped">8.26KB</td>
<td headers="double stub_1_44 gc.sec" class="gt_row gt_right gt_striped">8.416460</td></tr>
    <tr><th id="stub_1_45" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_45 n_unique" class="gt_row gt_right">1000</td>
<td headers="double stub_1_45 n_values" class="gt_row gt_right">1e+02</td>
<td headers="double stub_1_45 min" class="gt_row gt_center">183.96µs</td>
<td headers="double stub_1_45 median" class="gt_row gt_center">215.37µs</td>
<td headers="double stub_1_45 itr.sec" class="gt_row gt_right">4.383230e+03</td>
<td headers="double stub_1_45 mem_alloc" class="gt_row gt_center">14.77KB</td>
<td headers="double stub_1_45 gc.sec" class="gt_row gt_right">2.026458</td></tr>
    <tr><th id="stub_1_46" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_46 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="double stub_1_46 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="double stub_1_46 min" class="gt_row gt_center gt_striped">73.66µs</td>
<td headers="double stub_1_46 median" class="gt_row gt_center gt_striped">87.68µs</td>
<td headers="double stub_1_46 itr.sec" class="gt_row gt_right gt_striped">1.066273e+04</td>
<td headers="double stub_1_46 mem_alloc" class="gt_row gt_center gt_striped">9.38KB</td>
<td headers="double stub_1_46 gc.sec" class="gt_row gt_right gt_striped">8.390896</td></tr>
    <tr><th id="stub_1_47" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_47 n_unique" class="gt_row gt_right">10000</td>
<td headers="double stub_1_47 n_values" class="gt_row gt_right">1e+02</td>
<td headers="double stub_1_47 min" class="gt_row gt_center">186.25µs</td>
<td headers="double stub_1_47 median" class="gt_row gt_center">222.50µs</td>
<td headers="double stub_1_47 itr.sec" class="gt_row gt_right">4.232626e+03</td>
<td headers="double stub_1_47 mem_alloc" class="gt_row gt_center">15.09KB</td>
<td headers="double stub_1_47 gc.sec" class="gt_row gt_right">2.031986</td></tr>
    <tr><th id="stub_1_48" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_48 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="double stub_1_48 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="double stub_1_48 min" class="gt_row gt_center gt_striped">71.75µs</td>
<td headers="double stub_1_48 median" class="gt_row gt_center gt_striped">89.09µs</td>
<td headers="double stub_1_48 itr.sec" class="gt_row gt_right gt_striped">1.036752e+04</td>
<td headers="double stub_1_48 mem_alloc" class="gt_row gt_center gt_striped">9.52KB</td>
<td headers="double stub_1_48 gc.sec" class="gt_row gt_right gt_striped">6.198200</td></tr>
    <tr><th id="stub_1_49" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_49 n_unique" class="gt_row gt_right">10</td>
<td headers="double stub_1_49 n_values" class="gt_row gt_right">1e+03</td>
<td headers="double stub_1_49 min" class="gt_row gt_center">754.28µs</td>
<td headers="double stub_1_49 median" class="gt_row gt_center">874.44µs</td>
<td headers="double stub_1_49 itr.sec" class="gt_row gt_right">1.092062e+03</td>
<td headers="double stub_1_49 mem_alloc" class="gt_row gt_center">31.67KB</td>
<td headers="double stub_1_49 gc.sec" class="gt_row gt_right">2.022337</td></tr>
    <tr><th id="stub_1_50" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_50 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="double stub_1_50 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="double stub_1_50 min" class="gt_row gt_center gt_striped">92.84µs</td>
<td headers="double stub_1_50 median" class="gt_row gt_center gt_striped">108.10µs</td>
<td headers="double stub_1_50 itr.sec" class="gt_row gt_right gt_striped">8.604846e+03</td>
<td headers="double stub_1_50 mem_alloc" class="gt_row gt_center gt_striped">36.75KB</td>
<td headers="double stub_1_50 gc.sec" class="gt_row gt_right gt_striped">6.194994</td></tr>
    <tr><th id="stub_1_51" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_51 n_unique" class="gt_row gt_right">100</td>
<td headers="double stub_1_51 n_values" class="gt_row gt_right">1e+03</td>
<td headers="double stub_1_51 min" class="gt_row gt_center">839.79µs</td>
<td headers="double stub_1_51 median" class="gt_row gt_center">1.00ms</td>
<td headers="double stub_1_51 itr.sec" class="gt_row gt_right">9.691212e+02</td>
<td headers="double stub_1_51 mem_alloc" class="gt_row gt_center">43.24KB</td>
<td headers="double stub_1_51 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_52" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_52 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="double stub_1_52 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="double stub_1_52 min" class="gt_row gt_center gt_striped">104.47µs</td>
<td headers="double stub_1_52 median" class="gt_row gt_center gt_striped">124.50µs</td>
<td headers="double stub_1_52 itr.sec" class="gt_row gt_right gt_striped">7.498000e+03</td>
<td headers="double stub_1_52 mem_alloc" class="gt_row gt_center gt_striped">41.66KB</td>
<td headers="double stub_1_52 gc.sec" class="gt_row gt_right gt_striped">6.293789</td></tr>
    <tr><th id="stub_1_53" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_53 n_unique" class="gt_row gt_right">1000</td>
<td headers="double stub_1_53 n_values" class="gt_row gt_right">1e+03</td>
<td headers="double stub_1_53 min" class="gt_row gt_center">1.33ms</td>
<td headers="double stub_1_53 median" class="gt_row gt_center">1.63ms</td>
<td headers="double stub_1_53 itr.sec" class="gt_row gt_right">5.977333e+02</td>
<td headers="double stub_1_53 mem_alloc" class="gt_row gt_center">107.21KB</td>
<td headers="double stub_1_53 gc.sec" class="gt_row gt_right">2.033107</td></tr>
    <tr><th id="stub_1_54" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_54 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="double stub_1_54 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="double stub_1_54 min" class="gt_row gt_center gt_striped">151.83µs</td>
<td headers="double stub_1_54 median" class="gt_row gt_center gt_striped">178.51µs</td>
<td headers="double stub_1_54 itr.sec" class="gt_row gt_right gt_striped">5.235995e+03</td>
<td headers="double stub_1_54 mem_alloc" class="gt_row gt_center gt_striped">70.09KB</td>
<td headers="double stub_1_54 gc.sec" class="gt_row gt_right gt_striped">6.208690</td></tr>
    <tr><th id="stub_1_55" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_55 n_unique" class="gt_row gt_right">10000</td>
<td headers="double stub_1_55 n_values" class="gt_row gt_right">1e+03</td>
<td headers="double stub_1_55 min" class="gt_row gt_center">1.61ms</td>
<td headers="double stub_1_55 median" class="gt_row gt_center">1.89ms</td>
<td headers="double stub_1_55 itr.sec" class="gt_row gt_right">5.103910e+02</td>
<td headers="double stub_1_55 mem_alloc" class="gt_row gt_center">131.37KB</td>
<td headers="double stub_1_55 gc.sec" class="gt_row gt_right">2.025361</td></tr>
    <tr><th id="stub_1_56" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_56 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="double stub_1_56 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="double stub_1_56 min" class="gt_row gt_center gt_striped">164.47µs</td>
<td headers="double stub_1_56 median" class="gt_row gt_center gt_striped">196.84µs</td>
<td headers="double stub_1_56 itr.sec" class="gt_row gt_right gt_striped">4.797227e+03</td>
<td headers="double stub_1_56 mem_alloc" class="gt_row gt_center gt_striped">84.96KB</td>
<td headers="double stub_1_56 gc.sec" class="gt_row gt_right gt_striped">6.235563</td></tr>
    <tr><th id="stub_1_57" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_57 n_unique" class="gt_row gt_right">10</td>
<td headers="double stub_1_57 n_values" class="gt_row gt_right">1e+04</td>
<td headers="double stub_1_57 min" class="gt_row gt_center">7.43ms</td>
<td headers="double stub_1_57 median" class="gt_row gt_center">9.17ms</td>
<td headers="double stub_1_57 itr.sec" class="gt_row gt_right">1.105260e+02</td>
<td headers="double stub_1_57 mem_alloc" class="gt_row gt_center">362.61KB</td>
<td headers="double stub_1_57 gc.sec" class="gt_row gt_right">2.046778</td></tr>
    <tr><th id="stub_1_58" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_58 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="double stub_1_58 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="double stub_1_58 min" class="gt_row gt_center gt_striped">383.41µs</td>
<td headers="double stub_1_58 median" class="gt_row gt_center gt_striped">491.08µs</td>
<td headers="double stub_1_58 itr.sec" class="gt_row gt_right gt_striped">1.908236e+03</td>
<td headers="double stub_1_58 mem_alloc" class="gt_row gt_center gt_striped">338.84KB</td>
<td headers="double stub_1_58 gc.sec" class="gt_row gt_right gt_striped">10.450360</td></tr>
    <tr><th id="stub_1_59" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_59 n_unique" class="gt_row gt_right">100</td>
<td headers="double stub_1_59 n_values" class="gt_row gt_right">1e+04</td>
<td headers="double stub_1_59 min" class="gt_row gt_center">7.60ms</td>
<td headers="double stub_1_59 median" class="gt_row gt_center">9.13ms</td>
<td headers="double stub_1_59 itr.sec" class="gt_row gt_right">1.096944e+02</td>
<td headers="double stub_1_59 mem_alloc" class="gt_row gt_center">374.18KB</td>
<td headers="double stub_1_59 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_60" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_60 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="double stub_1_60 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="double stub_1_60 min" class="gt_row gt_center gt_striped">394.90µs</td>
<td headers="double stub_1_60 median" class="gt_row gt_center gt_striped">479.00µs</td>
<td headers="double stub_1_60 itr.sec" class="gt_row gt_right gt_striped">1.984618e+03</td>
<td headers="double stub_1_60 mem_alloc" class="gt_row gt_center gt_striped">343.76KB</td>
<td headers="double stub_1_60 gc.sec" class="gt_row gt_right gt_striped">12.735519</td></tr>
    <tr><th id="stub_1_61" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_61 n_unique" class="gt_row gt_right">1000</td>
<td headers="double stub_1_61 n_values" class="gt_row gt_right">1e+04</td>
<td headers="double stub_1_61 min" class="gt_row gt_center">8.64ms</td>
<td headers="double stub_1_61 median" class="gt_row gt_center">10.13ms</td>
<td headers="double stub_1_61 itr.sec" class="gt_row gt_right">9.553218e+01</td>
<td headers="double stub_1_61 mem_alloc" class="gt_row gt_center">465.49KB</td>
<td headers="double stub_1_61 gc.sec" class="gt_row gt_right">2.032600</td></tr>
    <tr><th id="stub_1_62" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_62 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="double stub_1_62 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="double stub_1_62 min" class="gt_row gt_center gt_striped">486.26µs</td>
<td headers="double stub_1_62 median" class="gt_row gt_center gt_striped">584.05µs</td>
<td headers="double stub_1_62 itr.sec" class="gt_row gt_right gt_striped">1.599042e+03</td>
<td headers="double stub_1_62 mem_alloc" class="gt_row gt_center gt_striped">388.49KB</td>
<td headers="double stub_1_62 gc.sec" class="gt_row gt_right gt_striped">9.870631</td></tr>
    <tr><th id="stub_1_63" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_63 n_unique" class="gt_row gt_right">10000</td>
<td headers="double stub_1_63 n_values" class="gt_row gt_right">1e+04</td>
<td headers="double stub_1_63 min" class="gt_row gt_center">13.67ms</td>
<td headers="double stub_1_63 median" class="gt_row gt_center">16.81ms</td>
<td headers="double stub_1_63 itr.sec" class="gt_row gt_right">5.966651e+01</td>
<td headers="double stub_1_63 mem_alloc" class="gt_row gt_center">1.03MB</td>
<td headers="double stub_1_63 gc.sec" class="gt_row gt_right">2.057466</td></tr>
    <tr><th id="stub_1_64" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_64 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="double stub_1_64 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="double stub_1_64 min" class="gt_row gt_center gt_striped">895.43µs</td>
<td headers="double stub_1_64 median" class="gt_row gt_center gt_striped">1.10ms</td>
<td headers="double stub_1_64 itr.sec" class="gt_row gt_right gt_striped">8.728566e+02</td>
<td headers="double stub_1_64 mem_alloc" class="gt_row gt_center gt_striped">689.60KB</td>
<td headers="double stub_1_64 gc.sec" class="gt_row gt_right gt_striped">8.372725</td></tr>
    <tr><th id="stub_1_65" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_65 n_unique" class="gt_row gt_right">10</td>
<td headers="double stub_1_65 n_values" class="gt_row gt_right">1e+05</td>
<td headers="double stub_1_65 min" class="gt_row gt_center">83.65ms</td>
<td headers="double stub_1_65 median" class="gt_row gt_center">88.47ms</td>
<td headers="double stub_1_65 itr.sec" class="gt_row gt_right">1.130538e+01</td>
<td headers="double stub_1_65 mem_alloc" class="gt_row gt_center">3.29MB</td>
<td headers="double stub_1_65 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_66" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_66 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="double stub_1_66 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="double stub_1_66 min" class="gt_row gt_center gt_striped">3.37ms</td>
<td headers="double stub_1_66 median" class="gt_row gt_center gt_striped">4.04ms</td>
<td headers="double stub_1_66 itr.sec" class="gt_row gt_right gt_striped">2.412714e+02</td>
<td headers="double stub_1_66 mem_alloc" class="gt_row gt_center gt_striped">3.17MB</td>
<td headers="double stub_1_66 gc.sec" class="gt_row gt_right gt_striped">13.403968</td></tr>
    <tr><th id="stub_1_67" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_67 n_unique" class="gt_row gt_right">100</td>
<td headers="double stub_1_67 n_values" class="gt_row gt_right">1e+05</td>
<td headers="double stub_1_67 min" class="gt_row gt_center">84.25ms</td>
<td headers="double stub_1_67 median" class="gt_row gt_center">87.69ms</td>
<td headers="double stub_1_67 itr.sec" class="gt_row gt_right">1.143737e+01</td>
<td headers="double stub_1_67 mem_alloc" class="gt_row gt_center">3.30MB</td>
<td headers="double stub_1_67 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_68" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_68 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="double stub_1_68 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="double stub_1_68 min" class="gt_row gt_center gt_striped">3.28ms</td>
<td headers="double stub_1_68 median" class="gt_row gt_center gt_striped">4.08ms</td>
<td headers="double stub_1_68 itr.sec" class="gt_row gt_right gt_striped">2.484759e+02</td>
<td headers="double stub_1_68 mem_alloc" class="gt_row gt_center gt_striped">3.18MB</td>
<td headers="double stub_1_68 gc.sec" class="gt_row gt_right gt_striped">15.369644</td></tr>
    <tr><th id="stub_1_69" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_69 n_unique" class="gt_row gt_right">1000</td>
<td headers="double stub_1_69 n_values" class="gt_row gt_right">1e+05</td>
<td headers="double stub_1_69 min" class="gt_row gt_center">85.96ms</td>
<td headers="double stub_1_69 median" class="gt_row gt_center">88.96ms</td>
<td headers="double stub_1_69 itr.sec" class="gt_row gt_right">1.109570e+01</td>
<td headers="double stub_1_69 mem_alloc" class="gt_row gt_center">3.39MB</td>
<td headers="double stub_1_69 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_70" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_70 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="double stub_1_70 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="double stub_1_70 min" class="gt_row gt_center gt_striped">3.50ms</td>
<td headers="double stub_1_70 median" class="gt_row gt_center gt_striped">4.32ms</td>
<td headers="double stub_1_70 itr.sec" class="gt_row gt_right gt_striped">2.253890e+02</td>
<td headers="double stub_1_70 mem_alloc" class="gt_row gt_center gt_striped">3.22MB</td>
<td headers="double stub_1_70 gc.sec" class="gt_row gt_right gt_striped">13.258179</td></tr>
    <tr><th id="stub_1_71" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_71 n_unique" class="gt_row gt_right">10000</td>
<td headers="double stub_1_71 n_values" class="gt_row gt_right">1e+05</td>
<td headers="double stub_1_71 min" class="gt_row gt_center">105.24ms</td>
<td headers="double stub_1_71 median" class="gt_row gt_center">107.19ms</td>
<td headers="double stub_1_71 itr.sec" class="gt_row gt_right">9.137631e+00</td>
<td headers="double stub_1_71 mem_alloc" class="gt_row gt_center">4.43MB</td>
<td headers="double stub_1_71 gc.sec" class="gt_row gt_right">2.284408</td></tr>
    <tr><th id="stub_1_72" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_72 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="double stub_1_72 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="double stub_1_72 min" class="gt_row gt_center gt_striped">5.22ms</td>
<td headers="double stub_1_72 median" class="gt_row gt_center gt_striped">6.29ms</td>
<td headers="double stub_1_72 itr.sec" class="gt_row gt_right gt_striped">1.606572e+02</td>
<td headers="double stub_1_72 mem_alloc" class="gt_row gt_center gt_striped">3.70MB</td>
<td headers="double stub_1_72 gc.sec" class="gt_row gt_right gt_striped">11.003919</td></tr>
    <tr><th id="stub_1_73" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_73 n_unique" class="gt_row gt_right">10</td>
<td headers="double stub_1_73 n_values" class="gt_row gt_right">1e+06</td>
<td headers="double stub_1_73 min" class="gt_row gt_center">970.46ms</td>
<td headers="double stub_1_73 median" class="gt_row gt_center">970.46ms</td>
<td headers="double stub_1_73 itr.sec" class="gt_row gt_right">1.030441e+00</td>
<td headers="double stub_1_73 mem_alloc" class="gt_row gt_center">30.89MB</td>
<td headers="double stub_1_73 gc.sec" class="gt_row gt_right">1.030441</td></tr>
    <tr><th id="stub_1_74" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_74 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="double stub_1_74 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="double stub_1_74 min" class="gt_row gt_center gt_striped">41.89ms</td>
<td headers="double stub_1_74 median" class="gt_row gt_center gt_striped">48.98ms</td>
<td headers="double stub_1_74 itr.sec" class="gt_row gt_right gt_striped">2.042542e+01</td>
<td headers="double stub_1_74 mem_alloc" class="gt_row gt_center gt_striped">34.70MB</td>
<td headers="double stub_1_74 gc.sec" class="gt_row gt_right gt_striped">14.854848</td></tr>
    <tr><th id="stub_1_75" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_75 n_unique" class="gt_row gt_right">100</td>
<td headers="double stub_1_75 n_values" class="gt_row gt_right">1e+06</td>
<td headers="double stub_1_75 min" class="gt_row gt_center">907.40ms</td>
<td headers="double stub_1_75 median" class="gt_row gt_center">907.40ms</td>
<td headers="double stub_1_75 itr.sec" class="gt_row gt_right">1.102045e+00</td>
<td headers="double stub_1_75 mem_alloc" class="gt_row gt_center">30.90MB</td>
<td headers="double stub_1_75 gc.sec" class="gt_row gt_right">1.102045</td></tr>
    <tr><th id="stub_1_76" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_76 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="double stub_1_76 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="double stub_1_76 min" class="gt_row gt_center gt_striped">40.22ms</td>
<td headers="double stub_1_76 median" class="gt_row gt_center gt_striped">43.27ms</td>
<td headers="double stub_1_76 itr.sec" class="gt_row gt_right gt_striped">1.975416e+01</td>
<td headers="double stub_1_76 mem_alloc" class="gt_row gt_center gt_striped">34.71MB</td>
<td headers="double stub_1_76 gc.sec" class="gt_row gt_right gt_striped">14.366662</td></tr>
    <tr><th id="stub_1_77" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_77 n_unique" class="gt_row gt_right">1000</td>
<td headers="double stub_1_77 n_values" class="gt_row gt_right">1e+06</td>
<td headers="double stub_1_77 min" class="gt_row gt_center">917.83ms</td>
<td headers="double stub_1_77 median" class="gt_row gt_center">917.83ms</td>
<td headers="double stub_1_77 itr.sec" class="gt_row gt_right">1.089525e+00</td>
<td headers="double stub_1_77 mem_alloc" class="gt_row gt_center">30.99MB</td>
<td headers="double stub_1_77 gc.sec" class="gt_row gt_right">0.000000</td></tr>
    <tr><th id="stub_1_78" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_78 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="double stub_1_78 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="double stub_1_78 min" class="gt_row gt_center gt_striped">38.51ms</td>
<td headers="double stub_1_78 median" class="gt_row gt_center gt_striped">41.45ms</td>
<td headers="double stub_1_78 itr.sec" class="gt_row gt_right gt_striped">2.423092e+01</td>
<td headers="double stub_1_78 mem_alloc" class="gt_row gt_center gt_striped">34.75MB</td>
<td headers="double stub_1_78 gc.sec" class="gt_row gt_right gt_striped">24.230915</td></tr>
    <tr><th id="stub_1_79" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="double stub_1_79 n_unique" class="gt_row gt_right">10000</td>
<td headers="double stub_1_79 n_values" class="gt_row gt_right">1e+06</td>
<td headers="double stub_1_79 min" class="gt_row gt_center">980.38ms</td>
<td headers="double stub_1_79 median" class="gt_row gt_center">980.38ms</td>
<td headers="double stub_1_79 itr.sec" class="gt_row gt_right">1.020018e+00</td>
<td headers="double stub_1_79 mem_alloc" class="gt_row gt_center">32.03MB</td>
<td headers="double stub_1_79 gc.sec" class="gt_row gt_right">1.020018</td></tr>
    <tr><th id="stub_1_80" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="double stub_1_80 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="double stub_1_80 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="double stub_1_80 min" class="gt_row gt_center gt_striped">49.50ms</td>
<td headers="double stub_1_80 median" class="gt_row gt_center gt_striped">56.88ms</td>
<td headers="double stub_1_80 itr.sec" class="gt_row gt_right gt_striped">1.699581e+01</td>
<td headers="double stub_1_80 mem_alloc" class="gt_row gt_center gt_striped">35.23MB</td>
<td headers="double stub_1_80 gc.sec" class="gt_row gt_right gt_striped">9.442115</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="8" class="gt_group_heading" scope="colgroup" id="integer">integer</th>
    </tr>
    <tr class="gt_row_group_first"><th id="stub_1_81" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_81 n_unique" class="gt_row gt_right">10</td>
<td headers="integer stub_1_81 n_values" class="gt_row gt_right">1e+02</td>
<td headers="integer stub_1_81 min" class="gt_row gt_center">32.32µs</td>
<td headers="integer stub_1_81 median" class="gt_row gt_center">38.20µs</td>
<td headers="integer stub_1_81 itr.sec" class="gt_row gt_right">2.415669e+04</td>
<td headers="integer stub_1_81 mem_alloc" class="gt_row gt_center">3.58KB</td>
<td headers="integer stub_1_81 gc.sec" class="gt_row gt_right">7.249183</td></tr>
    <tr><th id="stub_1_82" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_82 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="integer stub_1_82 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="integer stub_1_82 min" class="gt_row gt_center gt_striped">62.78µs</td>
<td headers="integer stub_1_82 median" class="gt_row gt_center gt_striped">73.18µs</td>
<td headers="integer stub_1_82 itr.sec" class="gt_row gt_right gt_striped">1.256084e+04</td>
<td headers="integer stub_1_82 mem_alloc" class="gt_row gt_center gt_striped">16.76KB</td>
<td headers="integer stub_1_82 gc.sec" class="gt_row gt_right gt_striped">10.456907</td></tr>
    <tr><th id="stub_1_83" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_83 n_unique" class="gt_row gt_right">100</td>
<td headers="integer stub_1_83 n_values" class="gt_row gt_right">1e+02</td>
<td headers="integer stub_1_83 min" class="gt_row gt_center">41.99µs</td>
<td headers="integer stub_1_83 median" class="gt_row gt_center">50.11µs</td>
<td headers="integer stub_1_83 itr.sec" class="gt_row gt_right">1.869101e+04</td>
<td headers="integer stub_1_83 mem_alloc" class="gt_row gt_center">10.05KB</td>
<td headers="integer stub_1_83 gc.sec" class="gt_row gt_right">6.334502</td></tr>
    <tr><th id="stub_1_84" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_84 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="integer stub_1_84 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="integer stub_1_84 min" class="gt_row gt_center gt_striped">65.37µs</td>
<td headers="integer stub_1_84 median" class="gt_row gt_center gt_striped">76.50µs</td>
<td headers="integer stub_1_84 itr.sec" class="gt_row gt_right gt_striped">1.201532e+04</td>
<td headers="integer stub_1_84 mem_alloc" class="gt_row gt_center gt_striped">5.97KB</td>
<td headers="integer stub_1_84 gc.sec" class="gt_row gt_right gt_striped">10.614242</td></tr>
    <tr><th id="stub_1_85" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_85 n_unique" class="gt_row gt_right">1000</td>
<td headers="integer stub_1_85 n_values" class="gt_row gt_right">1e+02</td>
<td headers="integer stub_1_85 min" class="gt_row gt_center">59.08µs</td>
<td headers="integer stub_1_85 median" class="gt_row gt_center">70.50µs</td>
<td headers="integer stub_1_85 itr.sec" class="gt_row gt_right">1.327254e+04</td>
<td headers="integer stub_1_85 mem_alloc" class="gt_row gt_center">13.95KB</td>
<td headers="integer stub_1_85 gc.sec" class="gt_row gt_right">4.123188</td></tr>
    <tr><th id="stub_1_86" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_86 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="integer stub_1_86 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="integer stub_1_86 min" class="gt_row gt_center gt_striped">66.88µs</td>
<td headers="integer stub_1_86 median" class="gt_row gt_center gt_striped">81.72µs</td>
<td headers="integer stub_1_86 itr.sec" class="gt_row gt_right gt_striped">1.139371e+04</td>
<td headers="integer stub_1_86 mem_alloc" class="gt_row gt_center gt_striped">6.90KB</td>
<td headers="integer stub_1_86 gc.sec" class="gt_row gt_right gt_striped">7.660497</td></tr>
    <tr><th id="stub_1_87" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_87 n_unique" class="gt_row gt_right">10000</td>
<td headers="integer stub_1_87 n_values" class="gt_row gt_right">1e+02</td>
<td headers="integer stub_1_87 min" class="gt_row gt_center">72.53µs</td>
<td headers="integer stub_1_87 median" class="gt_row gt_center">86.63µs</td>
<td headers="integer stub_1_87 itr.sec" class="gt_row gt_right">1.072501e+04</td>
<td headers="integer stub_1_87 mem_alloc" class="gt_row gt_center">14.37KB</td>
<td headers="integer stub_1_87 gc.sec" class="gt_row gt_right">4.108412</td></tr>
    <tr><th id="stub_1_88" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_88 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="integer stub_1_88 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="integer stub_1_88 min" class="gt_row gt_center gt_striped">65.66µs</td>
<td headers="integer stub_1_88 median" class="gt_row gt_center gt_striped">78.04µs</td>
<td headers="integer stub_1_88 itr.sec" class="gt_row gt_right gt_striped">1.193798e+04</td>
<td headers="integer stub_1_88 mem_alloc" class="gt_row gt_center gt_striped">7.56KB</td>
<td headers="integer stub_1_88 gc.sec" class="gt_row gt_right gt_striped">8.358467</td></tr>
    <tr><th id="stub_1_89" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_89 n_unique" class="gt_row gt_right">10</td>
<td headers="integer stub_1_89 n_values" class="gt_row gt_right">1e+03</td>
<td headers="integer stub_1_89 min" class="gt_row gt_center">60.49µs</td>
<td headers="integer stub_1_89 median" class="gt_row gt_center">73.18µs</td>
<td headers="integer stub_1_89 itr.sec" class="gt_row gt_right">1.267130e+04</td>
<td headers="integer stub_1_89 mem_alloc" class="gt_row gt_center">31.67KB</td>
<td headers="integer stub_1_89 gc.sec" class="gt_row gt_right">4.074372</td></tr>
    <tr><th id="stub_1_90" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_90 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="integer stub_1_90 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="integer stub_1_90 min" class="gt_row gt_center gt_striped">79.05µs</td>
<td headers="integer stub_1_90 median" class="gt_row gt_center gt_striped">91.22µs</td>
<td headers="integer stub_1_90 itr.sec" class="gt_row gt_right gt_striped">1.020784e+04</td>
<td headers="integer stub_1_90 mem_alloc" class="gt_row gt_center gt_striped">20.98KB</td>
<td headers="integer stub_1_90 gc.sec" class="gt_row gt_right gt_striped">8.268808</td></tr>
    <tr><th id="stub_1_91" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_91 n_unique" class="gt_row gt_right">100</td>
<td headers="integer stub_1_91 n_values" class="gt_row gt_right">1e+03</td>
<td headers="integer stub_1_91 min" class="gt_row gt_center">73.20µs</td>
<td headers="integer stub_1_91 median" class="gt_row gt_center">89.17µs</td>
<td headers="integer stub_1_91 itr.sec" class="gt_row gt_right">1.047815e+04</td>
<td headers="integer stub_1_91 mem_alloc" class="gt_row gt_center">42.46KB</td>
<td headers="integer stub_1_91 gc.sec" class="gt_row gt_right">4.116342</td></tr>
    <tr><th id="stub_1_92" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_92 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="integer stub_1_92 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="integer stub_1_92 min" class="gt_row gt_center gt_striped">83.63µs</td>
<td headers="integer stub_1_92 median" class="gt_row gt_center gt_striped">100.50µs</td>
<td headers="integer stub_1_92 itr.sec" class="gt_row gt_right gt_striped">9.265275e+03</td>
<td headers="integer stub_1_92 mem_alloc" class="gt_row gt_center gt_striped">25.11KB</td>
<td headers="integer stub_1_92 gc.sec" class="gt_row gt_right gt_striped">6.208583</td></tr>
    <tr><th id="stub_1_93" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_93 n_unique" class="gt_row gt_right">1000</td>
<td headers="integer stub_1_93 n_values" class="gt_row gt_right">1e+03</td>
<td headers="integer stub_1_93 min" class="gt_row gt_center">274.65µs</td>
<td headers="integer stub_1_93 median" class="gt_row gt_center">323.14µs</td>
<td headers="integer stub_1_93 itr.sec" class="gt_row gt_right">2.920490e+03</td>
<td headers="integer stub_1_93 mem_alloc" class="gt_row gt_center">102.23KB</td>
<td headers="integer stub_1_93 gc.sec" class="gt_row gt_right">2.032352</td></tr>
    <tr><th id="stub_1_94" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_94 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="integer stub_1_94 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="integer stub_1_94 min" class="gt_row gt_center gt_striped">140.13µs</td>
<td headers="integer stub_1_94 median" class="gt_row gt_center gt_striped">168.51µs</td>
<td headers="integer stub_1_94 itr.sec" class="gt_row gt_right gt_striped">5.533075e+03</td>
<td headers="integer stub_1_94 mem_alloc" class="gt_row gt_center gt_striped">49.28KB</td>
<td headers="integer stub_1_94 gc.sec" class="gt_row gt_right gt_striped">4.143074</td></tr>
    <tr><th id="stub_1_95" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_95 n_unique" class="gt_row gt_right">10000</td>
<td headers="integer stub_1_95 n_values" class="gt_row gt_right">1e+03</td>
<td headers="integer stub_1_95 min" class="gt_row gt_center">485.02µs</td>
<td headers="integer stub_1_95 median" class="gt_row gt_center">568.71µs</td>
<td headers="integer stub_1_95 itr.sec" class="gt_row gt_right">1.667310e+03</td>
<td headers="integer stub_1_95 mem_alloc" class="gt_row gt_center">124.02KB</td>
<td headers="integer stub_1_95 gc.sec" class="gt_row gt_right">2.030828</td></tr>
    <tr><th id="stub_1_96" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_96 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="integer stub_1_96 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="integer stub_1_96 min" class="gt_row gt_center gt_striped">132.77µs</td>
<td headers="integer stub_1_96 median" class="gt_row gt_center gt_striped">157.67µs</td>
<td headers="integer stub_1_96 itr.sec" class="gt_row gt_right gt_striped">6.041756e+03</td>
<td headers="integer stub_1_96 mem_alloc" class="gt_row gt_center gt_striped">61.76KB</td>
<td headers="integer stub_1_96 gc.sec" class="gt_row gt_right gt_striped">4.094717</td></tr>
    <tr><th id="stub_1_97" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_97 n_unique" class="gt_row gt_right">10</td>
<td headers="integer stub_1_97 n_values" class="gt_row gt_right">1e+04</td>
<td headers="integer stub_1_97 min" class="gt_row gt_center">366.20µs</td>
<td headers="integer stub_1_97 median" class="gt_row gt_center">447.64µs</td>
<td headers="integer stub_1_97 itr.sec" class="gt_row gt_right">2.085624e+03</td>
<td headers="integer stub_1_97 mem_alloc" class="gt_row gt_center">362.61KB</td>
<td headers="integer stub_1_97 gc.sec" class="gt_row gt_right">8.284503</td></tr>
    <tr><th id="stub_1_98" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_98 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="integer stub_1_98 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="integer stub_1_98 min" class="gt_row gt_center gt_striped">235.46µs</td>
<td headers="integer stub_1_98 median" class="gt_row gt_center gt_striped">293.28µs</td>
<td headers="integer stub_1_98 itr.sec" class="gt_row gt_right gt_striped">3.215825e+03</td>
<td headers="integer stub_1_98 mem_alloc" class="gt_row gt_center gt_striped">182.44KB</td>
<td headers="integer stub_1_98 gc.sec" class="gt_row gt_right gt_striped">8.261593</td></tr>
    <tr><th id="stub_1_99" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_99 n_unique" class="gt_row gt_right">100</td>
<td headers="integer stub_1_99 n_values" class="gt_row gt_right">1e+04</td>
<td headers="integer stub_1_99 min" class="gt_row gt_center">352.20µs</td>
<td headers="integer stub_1_99 median" class="gt_row gt_center">420.98µs</td>
<td headers="integer stub_1_99 itr.sec" class="gt_row gt_right">2.246573e+03</td>
<td headers="integer stub_1_99 mem_alloc" class="gt_row gt_center">373.40KB</td>
<td headers="integer stub_1_99 gc.sec" class="gt_row gt_right">8.297591</td></tr>
    <tr><th id="stub_1_100" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_100 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="integer stub_1_100 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="integer stub_1_100 min" class="gt_row gt_center gt_striped">267.18µs</td>
<td headers="integer stub_1_100 median" class="gt_row gt_center gt_striped">316.20µs</td>
<td headers="integer stub_1_100 itr.sec" class="gt_row gt_right gt_striped">2.963231e+03</td>
<td headers="integer stub_1_100 mem_alloc" class="gt_row gt_center gt_striped">186.58KB</td>
<td headers="integer stub_1_100 gc.sec" class="gt_row gt_right gt_striped">6.169115</td></tr>
    <tr><th id="stub_1_101" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_101 n_unique" class="gt_row gt_right">1000</td>
<td headers="integer stub_1_101 n_values" class="gt_row gt_right">1e+04</td>
<td headers="integer stub_1_101 min" class="gt_row gt_center">1.30ms</td>
<td headers="integer stub_1_101 median" class="gt_row gt_center">1.57ms</td>
<td headers="integer stub_1_101 itr.sec" class="gt_row gt_right">6.191932e+02</td>
<td headers="integer stub_1_101 mem_alloc" class="gt_row gt_center">457.68KB</td>
<td headers="integer stub_1_101 gc.sec" class="gt_row gt_right">4.100617</td></tr>
    <tr><th id="stub_1_102" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_102 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="integer stub_1_102 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="integer stub_1_102 min" class="gt_row gt_center gt_striped">315.48µs</td>
<td headers="integer stub_1_102 median" class="gt_row gt_center gt_striped">378.83µs</td>
<td headers="integer stub_1_102 itr.sec" class="gt_row gt_right gt_striped">2.518498e+03</td>
<td headers="integer stub_1_102 mem_alloc" class="gt_row gt_center gt_striped">224.28KB</td>
<td headers="integer stub_1_102 gc.sec" class="gt_row gt_right gt_striped">6.275328</td></tr>
    <tr><th id="stub_1_103" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_103 n_unique" class="gt_row gt_right">10000</td>
<td headers="integer stub_1_103 n_values" class="gt_row gt_right">1e+04</td>
<td headers="integer stub_1_103 min" class="gt_row gt_center">3.96ms</td>
<td headers="integer stub_1_103 median" class="gt_row gt_center">4.50ms</td>
<td headers="integer stub_1_103 itr.sec" class="gt_row gt_right">2.113766e+02</td>
<td headers="integer stub_1_103 mem_alloc" class="gt_row gt_center">999.46KB</td>
<td headers="integer stub_1_103 gc.sec" class="gt_row gt_right">2.013111</td></tr>
    <tr><th id="stub_1_104" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_104 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="integer stub_1_104 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="integer stub_1_104 min" class="gt_row gt_center gt_striped">717.99µs</td>
<td headers="integer stub_1_104 median" class="gt_row gt_center gt_striped">893.58µs</td>
<td headers="integer stub_1_104 itr.sec" class="gt_row gt_right gt_striped">1.092993e+03</td>
<td headers="integer stub_1_104 mem_alloc" class="gt_row gt_center gt_striped">481.78KB</td>
<td headers="integer stub_1_104 gc.sec" class="gt_row gt_right gt_striped">6.175100</td></tr>
    <tr><th id="stub_1_105" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_105 n_unique" class="gt_row gt_right">10</td>
<td headers="integer stub_1_105 n_values" class="gt_row gt_right">1e+05</td>
<td headers="integer stub_1_105 min" class="gt_row gt_center">3.57ms</td>
<td headers="integer stub_1_105 median" class="gt_row gt_center">4.11ms</td>
<td headers="integer stub_1_105 itr.sec" class="gt_row gt_right">2.342344e+02</td>
<td headers="integer stub_1_105 mem_alloc" class="gt_row gt_center">3.29MB</td>
<td headers="integer stub_1_105 gc.sec" class="gt_row gt_right">8.517615</td></tr>
    <tr><th id="stub_1_106" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_106 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="integer stub_1_106 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="integer stub_1_106 min" class="gt_row gt_center gt_striped">1.81ms</td>
<td headers="integer stub_1_106 median" class="gt_row gt_center gt_striped">2.19ms</td>
<td headers="integer stub_1_106 itr.sec" class="gt_row gt_right gt_striped">4.405907e+02</td>
<td headers="integer stub_1_106 mem_alloc" class="gt_row gt_center gt_striped">1.65MB</td>
<td headers="integer stub_1_106 gc.sec" class="gt_row gt_right gt_striped">8.392205</td></tr>
    <tr><th id="stub_1_107" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_107 n_unique" class="gt_row gt_right">100</td>
<td headers="integer stub_1_107 n_values" class="gt_row gt_right">1e+05</td>
<td headers="integer stub_1_107 min" class="gt_row gt_center">3.33ms</td>
<td headers="integer stub_1_107 median" class="gt_row gt_center">4.14ms</td>
<td headers="integer stub_1_107 itr.sec" class="gt_row gt_right">2.391865e+02</td>
<td headers="integer stub_1_107 mem_alloc" class="gt_row gt_center">3.30MB</td>
<td headers="integer stub_1_107 gc.sec" class="gt_row gt_right">10.178149</td></tr>
    <tr><th id="stub_1_108" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_108 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="integer stub_1_108 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="integer stub_1_108 min" class="gt_row gt_center gt_striped">2.07ms</td>
<td headers="integer stub_1_108 median" class="gt_row gt_center gt_striped">2.56ms</td>
<td headers="integer stub_1_108 itr.sec" class="gt_row gt_right gt_striped">3.850440e+02</td>
<td headers="integer stub_1_108 mem_alloc" class="gt_row gt_center gt_striped">1.65MB</td>
<td headers="integer stub_1_108 gc.sec" class="gt_row gt_right gt_striped">8.370522</td></tr>
    <tr><th id="stub_1_109" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_109 n_unique" class="gt_row gt_right">1000</td>
<td headers="integer stub_1_109 n_values" class="gt_row gt_right">1e+05</td>
<td headers="integer stub_1_109 min" class="gt_row gt_center">11.57ms</td>
<td headers="integer stub_1_109 median" class="gt_row gt_center">13.74ms</td>
<td headers="integer stub_1_109 itr.sec" class="gt_row gt_right">7.266913e+01</td>
<td headers="integer stub_1_109 mem_alloc" class="gt_row gt_center">3.38MB</td>
<td headers="integer stub_1_109 gc.sec" class="gt_row gt_right">2.018587</td></tr>
    <tr><th id="stub_1_110" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_110 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="integer stub_1_110 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="integer stub_1_110 min" class="gt_row gt_center gt_striped">2.18ms</td>
<td headers="integer stub_1_110 median" class="gt_row gt_center gt_striped">2.68ms</td>
<td headers="integer stub_1_110 itr.sec" class="gt_row gt_right gt_striped">3.608957e+02</td>
<td headers="integer stub_1_110 mem_alloc" class="gt_row gt_center gt_striped">1.69MB</td>
<td headers="integer stub_1_110 gc.sec" class="gt_row gt_right gt_striped">8.442005</td></tr>
    <tr><th id="stub_1_111" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_111 n_unique" class="gt_row gt_right">10000</td>
<td headers="integer stub_1_111 n_values" class="gt_row gt_right">1e+05</td>
<td headers="integer stub_1_111 min" class="gt_row gt_center">23.93ms</td>
<td headers="integer stub_1_111 median" class="gt_row gt_center">29.69ms</td>
<td headers="integer stub_1_111 itr.sec" class="gt_row gt_right">3.399195e+01</td>
<td headers="integer stub_1_111 mem_alloc" class="gt_row gt_center">4.35MB</td>
<td headers="integer stub_1_111 gc.sec" class="gt_row gt_right">2.124497</td></tr>
    <tr><th id="stub_1_112" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_112 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="integer stub_1_112 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="integer stub_1_112 min" class="gt_row gt_center gt_striped">3.22ms</td>
<td headers="integer stub_1_112 median" class="gt_row gt_center gt_striped">3.87ms</td>
<td headers="integer stub_1_112 itr.sec" class="gt_row gt_right gt_striped">2.502750e+02</td>
<td headers="integer stub_1_112 mem_alloc" class="gt_row gt_center gt_striped">2.10MB</td>
<td headers="integer stub_1_112 gc.sec" class="gt_row gt_right gt_striped">6.256876</td></tr>
    <tr><th id="stub_1_113" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_113 n_unique" class="gt_row gt_right">10</td>
<td headers="integer stub_1_113 n_values" class="gt_row gt_right">1e+06</td>
<td headers="integer stub_1_113 min" class="gt_row gt_center">38.40ms</td>
<td headers="integer stub_1_113 median" class="gt_row gt_center">43.01ms</td>
<td headers="integer stub_1_113 itr.sec" class="gt_row gt_right">2.226951e+01</td>
<td headers="integer stub_1_113 mem_alloc" class="gt_row gt_center">30.89MB</td>
<td headers="integer stub_1_113 gc.sec" class="gt_row gt_right">33.404263</td></tr>
    <tr><th id="stub_1_114" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_114 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="integer stub_1_114 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="integer stub_1_114 min" class="gt_row gt_center gt_striped">19.65ms</td>
<td headers="integer stub_1_114 median" class="gt_row gt_center gt_striped">23.26ms</td>
<td headers="integer stub_1_114 itr.sec" class="gt_row gt_right gt_striped">4.447170e+01</td>
<td headers="integer stub_1_114 mem_alloc" class="gt_row gt_center gt_striped">19.45MB</td>
<td headers="integer stub_1_114 gc.sec" class="gt_row gt_right gt_striped">22.235852</td></tr>
    <tr><th id="stub_1_115" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_115 n_unique" class="gt_row gt_right">100</td>
<td headers="integer stub_1_115 n_values" class="gt_row gt_right">1e+06</td>
<td headers="integer stub_1_115 min" class="gt_row gt_center">36.09ms</td>
<td headers="integer stub_1_115 median" class="gt_row gt_center">42.15ms</td>
<td headers="integer stub_1_115 itr.sec" class="gt_row gt_right">2.395859e+01</td>
<td headers="integer stub_1_115 mem_alloc" class="gt_row gt_center">30.90MB</td>
<td headers="integer stub_1_115 gc.sec" class="gt_row gt_right">35.937888</td></tr>
    <tr><th id="stub_1_116" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_116 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="integer stub_1_116 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="integer stub_1_116 min" class="gt_row gt_center gt_striped">21.73ms</td>
<td headers="integer stub_1_116 median" class="gt_row gt_center gt_striped">25.11ms</td>
<td headers="integer stub_1_116 itr.sec" class="gt_row gt_right gt_striped">4.004949e+01</td>
<td headers="integer stub_1_116 mem_alloc" class="gt_row gt_center gt_striped">19.45MB</td>
<td headers="integer stub_1_116 gc.sec" class="gt_row gt_right gt_striped">17.164067</td></tr>
    <tr><th id="stub_1_117" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_117 n_unique" class="gt_row gt_right">1000</td>
<td headers="integer stub_1_117 n_values" class="gt_row gt_right">1e+06</td>
<td headers="integer stub_1_117 min" class="gt_row gt_center">144.71ms</td>
<td headers="integer stub_1_117 median" class="gt_row gt_center">149.77ms</td>
<td headers="integer stub_1_117 itr.sec" class="gt_row gt_right">5.896183e+00</td>
<td headers="integer stub_1_117 mem_alloc" class="gt_row gt_center">30.98MB</td>
<td headers="integer stub_1_117 gc.sec" class="gt_row gt_right">5.896183</td></tr>
    <tr><th id="stub_1_118" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_118 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="integer stub_1_118 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="integer stub_1_118 min" class="gt_row gt_center gt_striped">22.26ms</td>
<td headers="integer stub_1_118 median" class="gt_row gt_center gt_striped">26.26ms</td>
<td headers="integer stub_1_118 itr.sec" class="gt_row gt_right gt_striped">3.795048e+01</td>
<td headers="integer stub_1_118 mem_alloc" class="gt_row gt_center gt_striped">19.49MB</td>
<td headers="integer stub_1_118 gc.sec" class="gt_row gt_right gt_striped">9.487620</td></tr>
    <tr><th id="stub_1_119" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="integer stub_1_119 n_unique" class="gt_row gt_right">10000</td>
<td headers="integer stub_1_119 n_values" class="gt_row gt_right">1e+06</td>
<td headers="integer stub_1_119 min" class="gt_row gt_center">224.44ms</td>
<td headers="integer stub_1_119 median" class="gt_row gt_center">224.44ms</td>
<td headers="integer stub_1_119 itr.sec" class="gt_row gt_right">4.455481e+00</td>
<td headers="integer stub_1_119 mem_alloc" class="gt_row gt_center">31.95MB</td>
<td headers="integer stub_1_119 gc.sec" class="gt_row gt_right">8.910961</td></tr>
    <tr><th id="stub_1_120" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="integer stub_1_120 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="integer stub_1_120 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="integer stub_1_120 min" class="gt_row gt_center gt_striped">32.80ms</td>
<td headers="integer stub_1_120 median" class="gt_row gt_center gt_striped">34.31ms</td>
<td headers="integer stub_1_120 itr.sec" class="gt_row gt_right gt_striped">2.738023e+01</td>
<td headers="integer stub_1_120 mem_alloc" class="gt_row gt_center gt_striped">19.90MB</td>
<td headers="integer stub_1_120 gc.sec" class="gt_row gt_right gt_striped">7.467335</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="8" class="gt_group_heading" scope="colgroup" id="date">date</th>
    </tr>
    <tr class="gt_row_group_first"><th id="stub_1_121" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_121 n_unique" class="gt_row gt_right">10</td>
<td headers="date stub_1_121 n_values" class="gt_row gt_right">1e+02</td>
<td headers="date stub_1_121 min" class="gt_row gt_center">212.03µs</td>
<td headers="date stub_1_121 median" class="gt_row gt_center">253.77µs</td>
<td headers="date stub_1_121 itr.sec" class="gt_row gt_right">3.719380e+03</td>
<td headers="date stub_1_121 mem_alloc" class="gt_row gt_center">80.95KB</td>
<td headers="date stub_1_121 gc.sec" class="gt_row gt_right">4.103012</td></tr>
    <tr><th id="stub_1_122" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_122 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="date stub_1_122 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="date stub_1_122 min" class="gt_row gt_center gt_striped">151.90µs</td>
<td headers="date stub_1_122 median" class="gt_row gt_center gt_striped">179.05µs</td>
<td headers="date stub_1_122 itr.sec" class="gt_row gt_right gt_striped">5.218195e+03</td>
<td headers="date stub_1_122 mem_alloc" class="gt_row gt_center gt_striped">21.48KB</td>
<td headers="date stub_1_122 gc.sec" class="gt_row gt_right gt_striped">8.355797</td></tr>
    <tr><th id="stub_1_123" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_123 n_unique" class="gt_row gt_right">100</td>
<td headers="date stub_1_123 n_values" class="gt_row gt_right">1e+02</td>
<td headers="date stub_1_123 min" class="gt_row gt_center">275.61µs</td>
<td headers="date stub_1_123 median" class="gt_row gt_center">326.20µs</td>
<td headers="date stub_1_123 itr.sec" class="gt_row gt_right">2.873541e+03</td>
<td headers="date stub_1_123 mem_alloc" class="gt_row gt_center">67.96KB</td>
<td headers="date stub_1_123 gc.sec" class="gt_row gt_right">4.134591</td></tr>
    <tr><th id="stub_1_124" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_124 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="date stub_1_124 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="date stub_1_124 min" class="gt_row gt_center gt_striped">212.14µs</td>
<td headers="date stub_1_124 median" class="gt_row gt_center gt_striped">253.52µs</td>
<td headers="date stub_1_124 itr.sec" class="gt_row gt_right gt_striped">3.760533e+03</td>
<td headers="date stub_1_124 mem_alloc" class="gt_row gt_center gt_striped">30.22KB</td>
<td headers="date stub_1_124 gc.sec" class="gt_row gt_right gt_striped">6.274527</td></tr>
    <tr><th id="stub_1_125" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_125 n_unique" class="gt_row gt_right">1000</td>
<td headers="date stub_1_125 n_values" class="gt_row gt_right">1e+02</td>
<td headers="date stub_1_125 min" class="gt_row gt_center">310.44µs</td>
<td headers="date stub_1_125 median" class="gt_row gt_center">374.61µs</td>
<td headers="date stub_1_125 itr.sec" class="gt_row gt_right">2.536468e+03</td>
<td headers="date stub_1_125 mem_alloc" class="gt_row gt_center">81.88KB</td>
<td headers="date stub_1_125 gc.sec" class="gt_row gt_right">4.158145</td></tr>
    <tr><th id="stub_1_126" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_126 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="date stub_1_126 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="date stub_1_126 min" class="gt_row gt_center gt_striped">245.94µs</td>
<td headers="date stub_1_126 median" class="gt_row gt_center gt_striped">293.62µs</td>
<td headers="date stub_1_126 itr.sec" class="gt_row gt_right gt_striped">3.195919e+03</td>
<td headers="date stub_1_126 mem_alloc" class="gt_row gt_center gt_striped">41.47KB</td>
<td headers="date stub_1_126 gc.sec" class="gt_row gt_right gt_striped">4.113152</td></tr>
    <tr><th id="stub_1_127" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_127 n_unique" class="gt_row gt_right">10000</td>
<td headers="date stub_1_127 n_values" class="gt_row gt_right">1e+02</td>
<td headers="date stub_1_127 min" class="gt_row gt_center">316.20µs</td>
<td headers="date stub_1_127 median" class="gt_row gt_center">377.55µs</td>
<td headers="date stub_1_127 itr.sec" class="gt_row gt_right">2.508771e+03</td>
<td headers="date stub_1_127 mem_alloc" class="gt_row gt_center">83.23KB</td>
<td headers="date stub_1_127 gc.sec" class="gt_row gt_right">4.160483</td></tr>
    <tr><th id="stub_1_128" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_128 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="date stub_1_128 n_values" class="gt_row gt_right gt_striped">1e+02</td>
<td headers="date stub_1_128 min" class="gt_row gt_center gt_striped">249.93µs</td>
<td headers="date stub_1_128 median" class="gt_row gt_center gt_striped">303.56µs</td>
<td headers="date stub_1_128 itr.sec" class="gt_row gt_right gt_striped">3.156371e+03</td>
<td headers="date stub_1_128 mem_alloc" class="gt_row gt_center gt_striped">42.69KB</td>
<td headers="date stub_1_128 gc.sec" class="gt_row gt_right gt_striped">4.155854</td></tr>
    <tr><th id="stub_1_129" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_129 n_unique" class="gt_row gt_right">10</td>
<td headers="date stub_1_129 n_values" class="gt_row gt_right">1e+03</td>
<td headers="date stub_1_129 min" class="gt_row gt_center">1.03ms</td>
<td headers="date stub_1_129 median" class="gt_row gt_center">1.26ms</td>
<td headers="date stub_1_129 itr.sec" class="gt_row gt_right">7.599801e+02</td>
<td headers="date stub_1_129 mem_alloc" class="gt_row gt_center">355.42KB</td>
<td headers="date stub_1_129 gc.sec" class="gt_row gt_right">2.026613</td></tr>
    <tr><th id="stub_1_130" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_130 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="date stub_1_130 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="date stub_1_130 min" class="gt_row gt_center gt_striped">179.82µs</td>
<td headers="date stub_1_130 median" class="gt_row gt_center gt_striped">211.82µs</td>
<td headers="date stub_1_130 itr.sec" class="gt_row gt_right gt_striped">4.457648e+03</td>
<td headers="date stub_1_130 mem_alloc" class="gt_row gt_center gt_striped">22.66KB</td>
<td headers="date stub_1_130 gc.sec" class="gt_row gt_right gt_striped">6.168332</td></tr>
    <tr><th id="stub_1_131" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_131 n_unique" class="gt_row gt_right">100</td>
<td headers="date stub_1_131 n_values" class="gt_row gt_right">1e+03</td>
<td headers="date stub_1_131 min" class="gt_row gt_center">1.15ms</td>
<td headers="date stub_1_131 median" class="gt_row gt_center">1.42ms</td>
<td headers="date stub_1_131 itr.sec" class="gt_row gt_right">6.904723e+02</td>
<td headers="date stub_1_131 mem_alloc" class="gt_row gt_center">400.74KB</td>
<td headers="date stub_1_131 gc.sec" class="gt_row gt_right">2.024846</td></tr>
    <tr><th id="stub_1_132" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_132 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="date stub_1_132 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="date stub_1_132 min" class="gt_row gt_center gt_striped">277.44µs</td>
<td headers="date stub_1_132 median" class="gt_row gt_center gt_striped">333.66µs</td>
<td headers="date stub_1_132 itr.sec" class="gt_row gt_right gt_striped">2.792841e+03</td>
<td headers="date stub_1_132 mem_alloc" class="gt_row gt_center gt_striped">61.77KB</td>
<td headers="date stub_1_132 gc.sec" class="gt_row gt_right gt_striped">4.107118</td></tr>
    <tr><th id="stub_1_133" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_133 n_unique" class="gt_row gt_right">1000</td>
<td headers="date stub_1_133 n_values" class="gt_row gt_right">1e+03</td>
<td headers="date stub_1_133 min" class="gt_row gt_center">1.71ms</td>
<td headers="date stub_1_133 median" class="gt_row gt_center">1.95ms</td>
<td headers="date stub_1_133 itr.sec" class="gt_row gt_right">4.772664e+02</td>
<td headers="date stub_1_133 mem_alloc" class="gt_row gt_center">640.05KB</td>
<td headers="date stub_1_133 gc.sec" class="gt_row gt_right">2.039600</td></tr>
    <tr><th id="stub_1_134" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_134 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="date stub_1_134 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="date stub_1_134 min" class="gt_row gt_center gt_striped">801.45µs</td>
<td headers="date stub_1_134 median" class="gt_row gt_center gt_striped">974.58µs</td>
<td headers="date stub_1_134 itr.sec" class="gt_row gt_right gt_striped">9.851580e+02</td>
<td headers="date stub_1_134 mem_alloc" class="gt_row gt_center gt_striped">268.58KB</td>
<td headers="date stub_1_134 gc.sec" class="gt_row gt_right gt_striped">4.104825</td></tr>
    <tr><th id="stub_1_135" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_135 n_unique" class="gt_row gt_right">10000</td>
<td headers="date stub_1_135 n_values" class="gt_row gt_right">1e+03</td>
<td headers="date stub_1_135 min" class="gt_row gt_center">2.11ms</td>
<td headers="date stub_1_135 median" class="gt_row gt_center">2.62ms</td>
<td headers="date stub_1_135 itr.sec" class="gt_row gt_right">3.699512e+02</td>
<td headers="date stub_1_135 mem_alloc" class="gt_row gt_center">777.01KB</td>
<td headers="date stub_1_135 gc.sec" class="gt_row gt_right">4.110569</td></tr>
    <tr><th id="stub_1_136" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_136 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="date stub_1_136 n_values" class="gt_row gt_right gt_striped">1e+03</td>
<td headers="date stub_1_136 min" class="gt_row gt_center gt_striped">1.14ms</td>
<td headers="date stub_1_136 median" class="gt_row gt_center gt_striped">1.47ms</td>
<td headers="date stub_1_136 itr.sec" class="gt_row gt_right gt_striped">6.445303e+02</td>
<td headers="date stub_1_136 mem_alloc" class="gt_row gt_center gt_striped">396.61KB</td>
<td headers="date stub_1_136 gc.sec" class="gt_row gt_right gt_striped">2.026825</td></tr>
    <tr><th id="stub_1_137" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_137 n_unique" class="gt_row gt_right">10</td>
<td headers="date stub_1_137 n_values" class="gt_row gt_right">1e+04</td>
<td headers="date stub_1_137 min" class="gt_row gt_center">10.04ms</td>
<td headers="date stub_1_137 median" class="gt_row gt_center">12.68ms</td>
<td headers="date stub_1_137 itr.sec" class="gt_row gt_right">8.095221e+01</td>
<td headers="date stub_1_137 mem_alloc" class="gt_row gt_center">3.49MB</td>
<td headers="date stub_1_137 gc.sec" class="gt_row gt_right">4.260643</td></tr>
    <tr><th id="stub_1_138" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_138 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="date stub_1_138 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="date stub_1_138 min" class="gt_row gt_center gt_striped">422.23µs</td>
<td headers="date stub_1_138 median" class="gt_row gt_center gt_striped">509.20µs</td>
<td headers="date stub_1_138 itr.sec" class="gt_row gt_right gt_striped">1.883980e+03</td>
<td headers="date stub_1_138 mem_alloc" class="gt_row gt_center gt_striped">184.13KB</td>
<td headers="date stub_1_138 gc.sec" class="gt_row gt_right gt_striped">4.082298</td></tr>
    <tr><th id="stub_1_139" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_139 n_unique" class="gt_row gt_right">100</td>
<td headers="date stub_1_139 n_values" class="gt_row gt_right">1e+04</td>
<td headers="date stub_1_139 min" class="gt_row gt_center">10.35ms</td>
<td headers="date stub_1_139 median" class="gt_row gt_center">12.70ms</td>
<td headers="date stub_1_139 itr.sec" class="gt_row gt_right">7.989483e+01</td>
<td headers="date stub_1_139 mem_alloc" class="gt_row gt_center">3.53MB</td>
<td headers="date stub_1_139 gc.sec" class="gt_row gt_right">2.048585</td></tr>
    <tr><th id="stub_1_140" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_140 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="date stub_1_140 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="date stub_1_140 min" class="gt_row gt_center gt_striped">529.68µs</td>
<td headers="date stub_1_140 median" class="gt_row gt_center gt_striped">622.88µs</td>
<td headers="date stub_1_140 itr.sec" class="gt_row gt_right gt_striped">1.544989e+03</td>
<td headers="date stub_1_140 mem_alloc" class="gt_row gt_center gt_striped">223.23KB</td>
<td headers="date stub_1_140 gc.sec" class="gt_row gt_right gt_striped">4.098113</td></tr>
    <tr><th id="stub_1_141" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_141 n_unique" class="gt_row gt_right">1000</td>
<td headers="date stub_1_141 n_values" class="gt_row gt_right">1e+04</td>
<td headers="date stub_1_141 min" class="gt_row gt_center">11.85ms</td>
<td headers="date stub_1_141 median" class="gt_row gt_center">14.45ms</td>
<td headers="date stub_1_141 itr.sec" class="gt_row gt_right">7.150409e+01</td>
<td headers="date stub_1_141 mem_alloc" class="gt_row gt_center">3.91MB</td>
<td headers="date stub_1_141 gc.sec" class="gt_row gt_right">2.042974</td></tr>
    <tr><th id="stub_1_142" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_142 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="date stub_1_142 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="date stub_1_142 min" class="gt_row gt_center gt_striped">1.44ms</td>
<td headers="date stub_1_142 median" class="gt_row gt_center gt_striped">1.74ms</td>
<td headers="date stub_1_142 itr.sec" class="gt_row gt_right gt_striped">5.499371e+02</td>
<td headers="date stub_1_142 mem_alloc" class="gt_row gt_center gt_striped">573.83KB</td>
<td headers="date stub_1_142 gc.sec" class="gt_row gt_right gt_striped">4.119379</td></tr>
    <tr><th id="stub_1_143" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_143 n_unique" class="gt_row gt_right">10000</td>
<td headers="date stub_1_143 n_values" class="gt_row gt_right">1e+04</td>
<td headers="date stub_1_143 min" class="gt_row gt_center">18.66ms</td>
<td headers="date stub_1_143 median" class="gt_row gt_center">21.65ms</td>
<td headers="date stub_1_143 itr.sec" class="gt_row gt_right">4.507378e+01</td>
<td headers="date stub_1_143 mem_alloc" class="gt_row gt_center">6.23MB</td>
<td headers="date stub_1_143 gc.sec" class="gt_row gt_right">4.292741</td></tr>
    <tr><th id="stub_1_144" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_144 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="date stub_1_144 n_values" class="gt_row gt_right gt_striped">1e+04</td>
<td headers="date stub_1_144 min" class="gt_row gt_center gt_striped">7.16ms</td>
<td headers="date stub_1_144 median" class="gt_row gt_center gt_striped">9.31ms</td>
<td headers="date stub_1_144 itr.sec" class="gt_row gt_right gt_striped">1.110423e+02</td>
<td headers="date stub_1_144 mem_alloc" class="gt_row gt_center gt_striped">2.62MB</td>
<td headers="date stub_1_144 gc.sec" class="gt_row gt_right gt_striped">2.056338</td></tr>
    <tr><th id="stub_1_145" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_145 n_unique" class="gt_row gt_right">10</td>
<td headers="date stub_1_145 n_values" class="gt_row gt_right">1e+05</td>
<td headers="date stub_1_145 min" class="gt_row gt_center">137.12ms</td>
<td headers="date stub_1_145 median" class="gt_row gt_center">143.20ms</td>
<td headers="date stub_1_145 itr.sec" class="gt_row gt_right">6.983176e+00</td>
<td headers="date stub_1_145 mem_alloc" class="gt_row gt_center">37.57MB</td>
<td headers="date stub_1_145 gc.sec" class="gt_row gt_right">6.983176</td></tr>
    <tr><th id="stub_1_146" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_146 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="date stub_1_146 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="date stub_1_146 min" class="gt_row gt_center gt_striped">2.81ms</td>
<td headers="date stub_1_146 median" class="gt_row gt_center gt_striped">3.60ms</td>
<td headers="date stub_1_146 itr.sec" class="gt_row gt_right gt_striped">2.753936e+02</td>
<td headers="date stub_1_146 mem_alloc" class="gt_row gt_center gt_striped">1.65MB</td>
<td headers="date stub_1_146 gc.sec" class="gt_row gt_right gt_striped">6.454538</td></tr>
    <tr><th id="stub_1_147" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_147 n_unique" class="gt_row gt_right">100</td>
<td headers="date stub_1_147 n_values" class="gt_row gt_right">1e+05</td>
<td headers="date stub_1_147 min" class="gt_row gt_center">135.43ms</td>
<td headers="date stub_1_147 median" class="gt_row gt_center">135.43ms</td>
<td headers="date stub_1_147 itr.sec" class="gt_row gt_right">7.384128e+00</td>
<td headers="date stub_1_147 mem_alloc" class="gt_row gt_center">34.62MB</td>
<td headers="date stub_1_147 gc.sec" class="gt_row gt_right">22.152385</td></tr>
    <tr><th id="stub_1_148" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_148 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="date stub_1_148 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="date stub_1_148 min" class="gt_row gt_center gt_striped">3.10ms</td>
<td headers="date stub_1_148 median" class="gt_row gt_center gt_striped">3.87ms</td>
<td headers="date stub_1_148 itr.sec" class="gt_row gt_right gt_striped">2.599122e+02</td>
<td headers="date stub_1_148 mem_alloc" class="gt_row gt_center gt_striped">1.69MB</td>
<td headers="date stub_1_148 gc.sec" class="gt_row gt_right gt_striped">12.032973</td></tr>
    <tr><th id="stub_1_149" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_149 n_unique" class="gt_row gt_right">1000</td>
<td headers="date stub_1_149 n_values" class="gt_row gt_right">1e+05</td>
<td headers="date stub_1_149 min" class="gt_row gt_center">141.90ms</td>
<td headers="date stub_1_149 median" class="gt_row gt_center">142.28ms</td>
<td headers="date stub_1_149 itr.sec" class="gt_row gt_right">7.028639e+00</td>
<td headers="date stub_1_149 mem_alloc" class="gt_row gt_center">35.00MB</td>
<td headers="date stub_1_149 gc.sec" class="gt_row gt_right">7.028639</td></tr>
    <tr><th id="stub_1_150" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_150 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="date stub_1_150 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="date stub_1_150 min" class="gt_row gt_center gt_striped">4.33ms</td>
<td headers="date stub_1_150 median" class="gt_row gt_center gt_striped">5.32ms</td>
<td headers="date stub_1_150 itr.sec" class="gt_row gt_right gt_striped">1.843777e+02</td>
<td headers="date stub_1_150 mem_alloc" class="gt_row gt_center gt_striped">2.03MB</td>
<td headers="date stub_1_150 gc.sec" class="gt_row gt_right gt_striped">9.218884</td></tr>
    <tr><th id="stub_1_151" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_151 n_unique" class="gt_row gt_right">10000</td>
<td headers="date stub_1_151 n_values" class="gt_row gt_right">1e+05</td>
<td headers="date stub_1_151 min" class="gt_row gt_center">174.31ms</td>
<td headers="date stub_1_151 median" class="gt_row gt_center">174.31ms</td>
<td headers="date stub_1_151 itr.sec" class="gt_row gt_right">5.737015e+00</td>
<td headers="date stub_1_151 mem_alloc" class="gt_row gt_center">38.99MB</td>
<td headers="date stub_1_151 gc.sec" class="gt_row gt_right">11.474029</td></tr>
    <tr><th id="stub_1_152" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_152 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="date stub_1_152 n_values" class="gt_row gt_right gt_striped">1e+05</td>
<td headers="date stub_1_152 min" class="gt_row gt_center gt_striped">18.82ms</td>
<td headers="date stub_1_152 median" class="gt_row gt_center gt_striped">21.31ms</td>
<td headers="date stub_1_152 itr.sec" class="gt_row gt_right gt_striped">4.602504e+01</td>
<td headers="date stub_1_152 mem_alloc" class="gt_row gt_center gt_striped">5.50MB</td>
<td headers="date stub_1_152 gc.sec" class="gt_row gt_right gt_striped">4.602504</td></tr>
    <tr><th id="stub_1_153" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_153 n_unique" class="gt_row gt_right">10</td>
<td headers="date stub_1_153 n_values" class="gt_row gt_right">1e+06</td>
<td headers="date stub_1_153 min" class="gt_row gt_center">1.93s</td>
<td headers="date stub_1_153 median" class="gt_row gt_center">1.93s</td>
<td headers="date stub_1_153 itr.sec" class="gt_row gt_right">5.185429e-01</td>
<td headers="date stub_1_153 mem_alloc" class="gt_row gt_center">371.70MB</td>
<td headers="date stub_1_153 gc.sec" class="gt_row gt_right">1.555629</td></tr>
    <tr><th id="stub_1_154" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_154 n_unique" class="gt_row gt_right gt_striped">10</td>
<td headers="date stub_1_154 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="date stub_1_154 min" class="gt_row gt_center gt_striped">30.45ms</td>
<td headers="date stub_1_154 median" class="gt_row gt_center gt_striped">39.97ms</td>
<td headers="date stub_1_154 itr.sec" class="gt_row gt_right gt_striped">2.181503e+01</td>
<td headers="date stub_1_154 mem_alloc" class="gt_row gt_center gt_striped">19.45MB</td>
<td headers="date stub_1_154 gc.sec" class="gt_row gt_right gt_striped">1.983185</td></tr>
    <tr><th id="stub_1_155" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_155 n_unique" class="gt_row gt_right">100</td>
<td headers="date stub_1_155 n_values" class="gt_row gt_right">1e+06</td>
<td headers="date stub_1_155 min" class="gt_row gt_center">2.00s</td>
<td headers="date stub_1_155 median" class="gt_row gt_center">2.00s</td>
<td headers="date stub_1_155 itr.sec" class="gt_row gt_right">4.987277e-01</td>
<td headers="date stub_1_155 mem_alloc" class="gt_row gt_center">343.74MB</td>
<td headers="date stub_1_155 gc.sec" class="gt_row gt_right">2.493638</td></tr>
    <tr><th id="stub_1_156" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_156 n_unique" class="gt_row gt_right gt_striped">100</td>
<td headers="date stub_1_156 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="date stub_1_156 min" class="gt_row gt_center gt_striped">29.75ms</td>
<td headers="date stub_1_156 median" class="gt_row gt_center gt_striped">33.77ms</td>
<td headers="date stub_1_156 itr.sec" class="gt_row gt_right gt_striped">2.695406e+01</td>
<td headers="date stub_1_156 mem_alloc" class="gt_row gt_center gt_striped">19.48MB</td>
<td headers="date stub_1_156 gc.sec" class="gt_row gt_right gt_striped">1.925290</td></tr>
    <tr><th id="stub_1_157" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_157 n_unique" class="gt_row gt_right">1000</td>
<td headers="date stub_1_157 n_values" class="gt_row gt_right">1e+06</td>
<td headers="date stub_1_157 min" class="gt_row gt_center">1.60s</td>
<td headers="date stub_1_157 median" class="gt_row gt_center">1.60s</td>
<td headers="date stub_1_157 itr.sec" class="gt_row gt_right">6.242363e-01</td>
<td headers="date stub_1_157 mem_alloc" class="gt_row gt_center">344.13MB</td>
<td headers="date stub_1_157 gc.sec" class="gt_row gt_right">1.872709</td></tr>
    <tr><th id="stub_1_158" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_158 n_unique" class="gt_row gt_right gt_striped">1000</td>
<td headers="date stub_1_158 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="date stub_1_158 min" class="gt_row gt_center gt_striped">33.80ms</td>
<td headers="date stub_1_158 median" class="gt_row gt_center gt_striped">39.44ms</td>
<td headers="date stub_1_158 itr.sec" class="gt_row gt_right gt_striped">2.069112e+01</td>
<td headers="date stub_1_158 mem_alloc" class="gt_row gt_center gt_striped">19.83MB</td>
<td headers="date stub_1_158 gc.sec" class="gt_row gt_right gt_striped">3.762021</td></tr>
    <tr><th id="stub_1_159" scope="row" class="gt_row gt_left gt_stub">factor(x)</th>
<td headers="date stub_1_159 n_unique" class="gt_row gt_right">10000</td>
<td headers="date stub_1_159 n_values" class="gt_row gt_right">1e+06</td>
<td headers="date stub_1_159 min" class="gt_row gt_center">1.67s</td>
<td headers="date stub_1_159 median" class="gt_row gt_center">1.67s</td>
<td headers="date stub_1_159 itr.sec" class="gt_row gt_right">5.985269e-01</td>
<td headers="date stub_1_159 mem_alloc" class="gt_row gt_center">348.12MB</td>
<td headers="date stub_1_159 gc.sec" class="gt_row gt_right">1.795581</td></tr>
    <tr><th id="stub_1_160" scope="row" class="gt_row gt_left gt_stub">fact(x)</th>
<td headers="date stub_1_160 n_unique" class="gt_row gt_right gt_striped">10000</td>
<td headers="date stub_1_160 n_values" class="gt_row gt_right gt_striped">1e+06</td>
<td headers="date stub_1_160 min" class="gt_row gt_center gt_striped">60.46ms</td>
<td headers="date stub_1_160 median" class="gt_row gt_center gt_striped">61.65ms</td>
<td headers="date stub_1_160 itr.sec" class="gt_row gt_right gt_striped">1.333716e+01</td>
<td headers="date stub_1_160 mem_alloc" class="gt_row gt_center gt_striped">23.30MB</td>
<td headers="date stub_1_160 gc.sec" class="gt_row gt_right gt_striped">3.334290</td></tr>
  </tbody>
  
  
</table>
</div>

``` r
f_plot <- function(x) {
  x$expression <- as.character(x$expression)
  # x$median <- log1p(x$median)
  # x <- tidyr::unnest(x, c(time, gc))
  # x$n_unique <- factor(x$n_unique)
  # x$n_values <- factor(x$n_values)
  ggplot2::ggplot(
    x, 
    ggplot2::aes_string(
      x = "n_values", 
      y = "median",
      col = "expression",
      group = "expression"
    )
  ) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::scale_x_continuous(
      trans = "log1p",
      breaks = 10^(2:6)
    ) +
    ggplot2::scale_y_continuous(trans = "log1p") +
    ggplot2::coord_trans("log1p", "log1p") +
    ggplot2::theme_light() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    ) +
    ggplot2::facet_grid(
      cols = ggplot2::vars(n_unique),
      rows = ggplot2::vars(value_type),
      scales = "free"
    ) +
    ggplot2::labs(
      x = "number of values",
      y = "median time",
      col = "function",
      title = "Median times across types and unique values"
    )
}
```

``` r
f_plot(res)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation ideoms with `aes()`
```

<img src="bench/figures/bench-unnamed-chunk-7-1.png" width="100%" />
