test_that("drop_levels() works", {
  x <- factor(1, 1:2)
  exp <- factor(1, 1)
  expect_equal(drop_levels(x), exp)

  df <- data.frame(x = x, y = 1)
  df_exp <- data.frame(x = exp, y = 1)
  expect_equal(drop_levels(df), df_exp)

  # facts and ordered
  x <- fact(1:10)
  expect_identical(drop_levels(x), x)

  x <- as_ordered(factor(1, 1:2))
  exp <- struct(
    1L,
    class = c("fact", "ordered", "factor"),
    levels = "1",
    values = "1",
    na = 0L
  )
  expect_equal(drop_levels(x), exp)
})
