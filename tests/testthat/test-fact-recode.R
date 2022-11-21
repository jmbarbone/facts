test_that("fact_recode()", {
  x <- letters[1:5]
  obj <- fact_recode(x, z = "a", y = "b")
  exp <- fact(c("z", "y", "c", "d", "e"))
  expect_identical(obj, exp)

  x <- fact(c(1.1, NA, 2.0))
  obj <- fact_recode(x, old = c(1.1, 2.0), new = c(1, 0))
  exp <- fact(c(1, NA, 0))
  expect_identical(obj, exp)

  obj <- fact_recode(fact("a"), new = "b")
  exp <- fact("b")
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
