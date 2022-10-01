test_that("as_ordered() works", {
  res <- fact(c(1:3, NA_integer_))
  exp <- struct(
    c(1:3, NA_integer_),
    c("fact", "ordered", "factor"),
    levels = as.character(1:3),
    uniques = 1:3,
    na = 0L
  )
  expect_identical(as_ordered(res), exp)
})

test_that("as_ordered() doesn't duplicate class", {
  res <- class(as_ordered(as.ordered(letters[1:3])))
  expect_identical(res, c("fact", "ordered", "factor"))
})
