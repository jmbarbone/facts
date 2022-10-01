test_that("fact_reverse() works", {
  res <- fact_reverse(1:4)
  exp <- new_fact(4:1, 4:1)
  expect_identical(res, exp)

  res <- fact_reverse(as_ordered(1:4))
  exp <- new_fact(4:1, 4:1, ordered = TRUE)
  expect_identical(res, exp)

  res <- fact_reverse(c(1:3, NA))
  exp <- new_fact(c(3:1, 4L), c(3:1, NA))
  expect_identical(res, exp)

  res <- fact_reverse(as_ordered(c(1:3, NA)))
  exp <- mark::struct(
    c(3:1, NA),
    class = c("fact", "ordered", "factor"),
    values = 3:1,
    levels = c("3", "2", "1"),
    na = 0L
  )

  expect_identical(res, exp)
})
