test_that("[.fact() works", {
  x <- fact(1:3)
  x1 <- do.call(structure, c(1, attributes(x)))
  x2 <- do.call(structure, c(2, attributes(x)))
  expect_identical(x[1], x1)
  expect_identical(x[2], x2)
})

test_that("is.na.fact(), works", {
  x <- fact(c(1, 2, NA, 3))
  res <- is.na(x)
  exp <- c(FALSE, FALSE, FALSE, FALSE)
  expect_identical(res, exp)

  x <- fact_na(c(1, 2, NA, 3))
  res <- is.na(x)
  exp <- c(FALSE, FALSE, TRUE, FALSE)
  expect_identical(res, exp)

  x <- fact_na(c("a", "b", "c"))
  res <- is.na(x)
  exp <- c(FALSE, FALSE, FALSE)
  expect_identical(res, exp)
})

test_that("as.integer.fact() works", {
  x <- fact(c(1, 2, NA, 3))
  res <- as.integer(x)
  exp <- c(1L, 2L, NA_integer_, 3L)
  expect_identical(res, exp)
})

test_that("as.integer.fact() works", {
  x <- fact(c(1, 2, NA, 3))
  res <- as.double(x)
  exp <- c(1, 2, NA_real_, 3)
  expect_identical(res, exp)
  expect_identical(as.numeric(x), exp)
})

test_that("unique.fact() works", {
  x <- fact(c(1, 2, NA, 3, 2))
  exp <- fact(c(1, 2, NA, 3))
  res <- unique(x)
  expect_identical(exp, res)

  x <- as_ordered(x)
  exp <- as_ordered(exp)
  res <- unique(x)
  expect_identical(exp, res)
})

test_that("as.Date.fact() works", {
  x <- c("2022-01-02", NA, "1908-12-21")
  exp <- as.Date(x)
  res <- as.Date(fact(exp))
  expect_identical(exp, res)

  x <- c("01-01-2022", "01-02-2000")
  exp <- as.Date(x, "%d-%m-%Y")
  res <- as.Date(fact(x), "%d-%m-%Y")
  expect_identical(exp, res)
})

test_that("as.character.fact() works", {
  exp <- c("a", NA_character_, "b", "b", "a")
  res <- as.character(fact(exp))
  expect_identical(exp, res)
})

test_that("format.fact()", {
  obj <- format(fact(1))
  exp <- "1 [1]"
  expect_identical(obj, exp)

  obj <- format(fact(c("a", "b", "c")))
  exp <- c("1 [a]", "2 [b]", "3 [c]")
  expect_identical(obj, exp)
})

test_that("pillar_shaft.fact()", {
  expect_no_error(pillar_shaft(fact(1:100)))
})
