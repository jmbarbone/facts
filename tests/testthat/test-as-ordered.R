test_that("as.ordered() works", {
  res <- as.ordered(fact(c(1:3, NA_integer_)))
  exp <- struct(
    c(1:3, NA),
    class = c("ordered", "fact", "factor"),
    levels = c(as.character(1:3)),
    ptype = integer()
  )
  expect_identical(res, exp)
  expect_identical(res > exp, c(FALSE, FALSE, FALSE, NA))
})

test_that("as.ordered() doesn't duplicate class", {
  res <- class(as.ordered(fact(letters[1:3])))
  exp <- c("ordered", "fact", "factor")
  expect_identical(res, exp)
})
