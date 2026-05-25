test_that("values()", {
  expect_identical(values(fact("a")), "a")
  expect_identical(values(fact(as.Date("1992-12-17"))), as.Date("1992-12-17"))
})
