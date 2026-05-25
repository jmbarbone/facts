test_that("values()", {
  exp <- c(1, 2, 2, 0)
  obj <- values(fact(exp))
  expect_identical(obj, exp)
})
