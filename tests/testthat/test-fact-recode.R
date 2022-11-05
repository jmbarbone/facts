test_that("fact_recode()", {
  x <- letters[1:5]
  obj <- fact_recode(x, z = "a", y = "b")
  exp <- fact(c("z", "y", "c", "d", "e"))
  expect_identical(obj, exp)
})

test_that("conditions", {
  expect_error(fact_recode(1, 1, old = 1), class = "factRecodeDotsError")
  expect_error(fact_recode(1), class = "factRecodeNewError")
  expect_error(
    fact_recode(1, old = integer(), new = 1),
    class = "factRecodeOldError"
  )
})
