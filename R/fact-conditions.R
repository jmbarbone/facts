
fact_na_condition <- function() {
  new_condition(
    collapse(
      "\ndefault na label must be an object that can be coherced to a ",
      "character vector of length 1",
      "\nnote: you can change the value with options(fact.na.label)"
    ),
    class = "fact_na_label"
  )
}

fact_inherits_condition <- function() {
  new_condition(
    "`x` must be a 'fact' class",
    class = "fact_na_class"
  )
}

fact_range_numeric_condition <- function() {
  new_condition("range must be a numeric vector", class = "fact_range_numeric")
}

fact_range_date_condition <- function() {
  new_condition("range must be a Date vector", class = "fact_range_date")
}

fact_range_types_condition <- function() {
  new_condition(
    "x and range are incompatible types",
    class = "fact_range_types"
  )
}

fact_range_missing_condition <- function() {
  new_condition(
    "range does not have any non-missing values",
    class = "fact_range_missing"
  )
}

fact_range_finite_condition <- function() {
  new_condition(
    "range does not have enough finite values",
    class = "fact_range_finite"
  )
}
