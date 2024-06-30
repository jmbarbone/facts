test_that("as_ordered() works", {
  res <- as_ordered(fact(c(1:3, NA_integer_)))
  exp <- struct(
    1:4,
    c("fact", "ordered", "factor", "vctrs_vctr"),
    levels = c(as.character(1:3), "(na)"),
    values = c(1:3, NA_integer_),
    na = 4L
  )
  expect_identical(res, exp)
  expect_identical(res > exp, c(FALSE, FALSE, FALSE, NA))
})

test_that("as_ordered() doesn't duplicate class", {
  res <- class(as_ordered(as.ordered(letters[1:3])))
  expect_identical(res, c("fact", "ordered", "factor", "vctrs_vctr"))
})
