
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
  new_condition("`x` must be a 'fact' class", class = "fact_na_class")
}

fact_range_numeric_condition <- function() {
  new_condition("range must be a numeric vector", class = "fact_range_numeric")
}

fact_range_date_condition <- function() {
  new_condition("range must be a date vector", class = "fact_range_date")
}

fact_range_types_condition <- function() {
  new_condition("incompatible types for x and range", class = "fact_range_type")
}

fact_range_missing_condition <- function() {
  new_condition(
    "range does not contain non-missing values",
    class = "fact_range_missing"
  )
}

fact_range_finite_condition <- function() {
  new_condition(
    "not enough finite values in range",
    class = "fact_range_finite"
  )
}
