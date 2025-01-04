
test_that("fact.default() fails", {
  expect_error(fact(struct(NULL, "foo")), class = "factMethodError")
})

test_that("fact.logical()", {
  x <- fact(c(TRUE, FALSE, NA))
  expect_message(expect_output(print(x)), NA)

  x <- fact(c(FALSE, NA, NA, TRUE, FALSE))
  res <- new_fact(c(1L, 3L, 3L, 2L, 1L), c(FALSE, TRUE, NA))
  expect_identical(x, res)

  expect_true(anyNA(x))
})

test_that("fact.pseudo_id()", {
  expect_message(
    expect_output(
      print(fact(pseudo_id(c("a", "a", "b", NA_character_))))
    ),
    NA
  )

  # Should appropriately order numeric values
  x <- c(0L, 10L, 10L, NA, 0L, 5L)
  id <- pseudo_id(x)
  f <- fact(id)
  res <- new_fact(c(1L, 3L, 3L, 4L, 1L, 2L), c(0L, 5L, 10L, NA_integer_))

  expect_identical(fact(x), f)
  expect_identical(fact(x), res)
  expect_true(anyNA(fact(x)))

  # pseudo_id() ordered by appearance, fact() has pre-set ordering
  expect_identical(pseudo_id(f), id)

  # attr(id, "uniques") <- as.character(attr(id, "uniques"))
  # factors store levels as characters
  o <- order(as.integer(values(f)))
  expect_identical(o, 1:4)
})

test_that("fact.integer()", {
  expect_equal(
    fact(struct(1L, c("foo", "integer"))),
    new_fact(1L, struct(1L, c("foo", "integer")))
  )
})

test_that("fact.numeric()", {
  op <- options()

  options(facts.guess.integer = FALSE)
  obj <- fact(struct(1, c("foo", "numeric")))
  exp <- new_fact(1, struct(1, c("foo", "numeric")))
  expect_equal(obj, exp)

  options(facts.guess.integer = TRUE)
  obj <- fact(struct(1, c("foo", "numeric")))
  exp <- new_fact(1L, struct(1L, c("foo", "integer")))
  expect_equal(obj, exp)

  options(op)
})

test_that("fact.factor()", {
  # x <- fact(as.character(c(Sys.Date() + 5:1, NA))[sample(1:6, 20, TRUE)])

  x <- factor(letters)
  class(x) <- c("fact", "factor", "vctrs_vctr")
  expect_identical(fact(x), x)

  x <- ordered(letters)
  class(x) <- c("fact", "ordered", "factor", "vctrs_vctr")
  expect_identical(fact(x), x)

  x <- struct(1L, c("fact", "factor"), levels = c("a", NA_character_))
  expect_identical(fact(x), x)

  # fact.fact() checks for NA and adds
  x <- factor(c(1, NA, 2))
  expect_identical(levels(fact(x)), c("1", "2", "(na)"))
})

test_that("fact() ignores NaN", {
  # ignore NaN
  obj <- fact(c(1, 2, NA, 3, NaN))
  exp <- struct(
    c(1L, 2L, 4L, 3L, 5L),
    class = c("fact", "factor", "vctrs_vctr"),
    values = c(1, 2, 3, NA, NaN),
    levels = c("1", "2", "3", "(na)", "(nan)"),
    na = 4:5
  )

  expect_identical(obj, exp)
})

test_that("ranges", {
  obj <- fact(c(1L, 3L, 2L), range = c(1L, 10L))
  exp <- struct(
    c(1L, 3L, 2L),
    class = c("fact", "factor", "vctrs_vctr"),
    levels = as.character(1:10),
    values = c(1L, 2L, 3L),
    range = c(1L, 10L),
    na = 0L
  )
  expect_identical(obj, exp)

  obj <- range_safe(as.Date("2022-01-01") + 0:10, as.Date("2022-01-01"))
  exp <- as.Date("2022-01-01") + 0:10
  expect_identical(obj, exp)

  obj <- fact(as.Date("2022-01-01"), range = as.Date("2022-01-01") + c(0, 10))
  exp <- new_fact(
    1,
    values = as.Date("2022-01-01"),
    levels = as.character(as.Date("2022-01-01") + 0:10),
    range = as.Date("2022-01-01") + c(0, 10)
  )
  expect_identical(obj, exp)

  foo <- function() { struct(list(), "foo") }
  expect_error(range_safe("a", 1), class = "factRangeNumericError")
  expect_error(range_safe(1, Sys.Date()), class = "factRangeDateError")
  # because I don't know what to do about these
  expect_error(range_safe(foo(), foo()), class = "factRangeTypesError")

  expect_error(range_safe(NA_integer_, 1L), class = "factRangeFiniteError")
  expect_error(range_safe(Inf, 1L), class = "factRangeFiniteError")
})
