test_that("as_values()", {
  expect_identical(as_values(1L), 1L)

  exp <- c(1, 2, 2, 0)
  obj <- as_values(fact(exp))
  expect_identical(obj, exp)

  exp <- letters
  obj <- as_values(factor(letters))
  expect_identical(exp, obj)

  exp <- c(2.2, NA, 1.1)
  obj <- as_values(factor(exp), "double")
  expect_identical(exp, obj)

  exp <- c(2L, NA, 1L)
  obj <- as_values(factor(exp), "integer")
  expect_identical(exp, obj)

  exp <- as.Date(c("2022-01-01", "2023-02-03"))
  obj <- as_values(factor(exp), "date")
  expect_identical(exp, obj)

  exp <- c(2.2, NA, 1.1)
  obj <- as_values(factor(exp), as.numeric)
  expect_identical(exp, obj)
  exp <- c(2.2, NA, 1.1)

  obj <- as_values(factor(exp), "as.numeric")
  expect_identical(exp, obj)
})
