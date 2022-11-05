
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

fact_method_condition <- function(x) {
  new_condition(
    c("no fact method for class(es)", collapse(class(x), sep = ", ")),
    class = "fact_method"
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

fact_range_finite_condition <- function() {
  new_condition(
    "range does not have enough finite values",
    class = "fact_range_finite"
  )
}


# recode ------------------------------------------------------------------

fact_recode_dots_condition <- function() {
  new_condition(
    "if ... are used, old and new must be NULL",
    class = "fact_recode_dots"
  )
}

fact_recode_old_condition <- function() {
  new_condition("old values have not been set", class = "fact_recode_old")
}

fact_recode_new_condition <- function() {
  new_condition("new values have not been set", class = "fact_recode_new")
}
