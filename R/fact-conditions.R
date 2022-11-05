
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
