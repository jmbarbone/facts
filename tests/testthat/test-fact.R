
test_that("fact.default() fails", {
  expect_error(fact(struct(NULL, "foo")), class = "factMethodError")
})

test_that("fact.logical() works", {
  x <- fact(c(TRUE, FALSE, NA))
  expect_message(capture.output(print(x)), NA)

  x <- fact(c(FALSE, NA, NA, TRUE, FALSE))
  res <- new_fact(c(2L, 3L, 3L, 1L, 2L), c(TRUE, FALSE, NA))
  expect_identical(x, res)

  expect_false(anyNA(x))
})

test_that("fact.pseudo_id() works", {
  expect_message(capture.output(print(fact(pseudo_id(c("a", "a", "b", NA_character_))))), NA)

  # Should appropriately order numeric values
  x <- c(0L, 10L, 10L, NA, 0L, 5L)
  id <- pseudo_id(x)
  f <- fact(id)
  res <- new_fact(c(1L, 3L, 3L, 4L, 1L, 2L), c(0L, 5L, 10L, NA_integer_))

  expect_identical(fact(x), f)
  expect_identical(fact(x), res)

  # Shouldn't have any NA
  expect_false(anyNA(fact(x)))

  # pseudo_id() ordered by appearance, fact() has pre-set ordering
  expect_identical(pseudo_id(f), id)

  # attr(id, "uniques") <- as.character(attr(id, "uniques"))
  # factors store levels as characters
  o <- order(as.integer(values(f)))
  expect_identical(o, 1:4)
})

test_that("fact.integer() works", {
  expect_equal(
    fact(struct(1L, c("foo", "integer"))),
    new_fact(1L, struct(1L, c("foo", "integer")))
  )
})

test_that("fact.factor() works", {
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
  expect_identical(levels(fact(x)), c("1", "2"))
  converted <- fact(x, convert = TRUE)
  expect_identical(levels(converted), c("1", "2", "(na)"))
  expect_identical(values(converted), c(1L, 2L, NA))

  # moves NA to the end and reordered when number
  x <- factor(c(1, NA, 2), c(2, NA, 1), exclude = NULL)
  res <- new_fact(c(1L, 3L, 2L), c(1L, 2L, NA))
  expect_identical(fact(x, convert = TRUE), res)

  x <- factor(c(NA, TRUE, FALSE))
  res <- new_fact(c(3L, 1L, 2L), c(TRUE, FALSE, NA))
  expect_identical(fact(x, convert = TRUE), res)

  x <- factor(c(NA, TRUE, FALSE), exclude = NULL)
  res <- new_fact(c(3L, 1L, 2L), c(TRUE, FALSE, NA))
  expect_identical(fact(x, convert = TRUE), res)
})

test_that("fact.haven_labelled() works", {
  skip_if_not_installed("haven")
  .haven_as_factor <- "haven" %colons% "as_factor.haven_labelled"
  haven_as_fact <- function(..., .convert = NULL) {
    res <- fact(.haven_as_factor(...), convert = .convert)
    attr(res, "label") <- exattr(..1, "label")
    res
  }

  expect_id_fact <- function(x, convert = NULL) {
    testthat::expect_identical(
      fact(x),
      haven_as_fact(x, .convert = convert),
      ignore_attr = c("values", "na")
    )
  }

  # Integers
  r <- rep(1:3, 2)
  x <- haven::labelled(r, labels = c(good = 1, bad = 3))
  expect_id_fact(x)

  x <- haven::labelled(r, labels = c(good = 1, bad = 3), label = "this")
  expect_id_fact(x)

  x <- haven::labelled(r, labels = c(good = 1, neutral = 2, bad = 3), label = "this")
  expect_id_fact(x)

  x <- haven::labelled(r, label = "this")
  expect_id_fact(x, convert = TRUE)

  # Doubles
  x <- haven::labelled(c(0, 0.5, 1), c(a = 0, b = 1))
  expect_id_fact(x, convert = TRUE)

  # Character
  x <- haven::labelled(letters, c(good = "j", something = "m", cool = "b"))
  expect_id_fact(x)

  # Unique not in levels; levels not in unique
  x <- haven::labelled(
    c(-10, 20, 40, 60),
    labels = c(a = 10, b = 20, c = 30, d = 40),
    label = "foo"
  )
  expect_id_fact(x)
})

test_that("fact() correctly labels NAs [mark#24]", {
  expect_equal(
    fact(c(NA, "a", "b")),
    new_fact(c(3L, 1L, 2L), c("a", "b", NA))
  )

  expect_equal(
    fact(c(NA, 1, 3)),
    new_fact(c(3L, 1L, 2L), c(1, 3, NA))
  )

  expect_equal(
    fact(c(1, NA, NA, 3)),
    new_fact(c(1L, 3L, 3L, 2L), c(1, 3, NA))
  )

  expect_equal(
    fact(c(TRUE, TRUE, NA, FALSE, TRUE)),
    new_fact(c(1L, 1L, 3L, 2L, 1L), c(TRUE, FALSE, NA))
  )
})

test_that("fact() ignores NaN", {
  # ignore NaN
  res <- fact(c(1, 2, NA, 3, NaN))
  exp <- struct(
    c(1L, 2L, 4L, 3L, 4L),
    class = c("fact", "factor", "vctrs_vctr"),
    values = c(1, 2, 3, NA),
    levels = c("1", "2", "3", "(na)"),
    na = 4L
  )

  expect_identical(res, exp)
})

test_that("ranges", {
  expect_identical(
    fact(c(1L, 3L, 2L), range = c(1, 10)),
    struct(
      c(1L, 3L, 2L),
      class = c("fact", "factor", "vctrs_vctr"),
      levels = as.character(1:10),
      values = c(1L, 2L, 3L),
      range = c(1L, 10L),
      na = 0L
    )
  )

  foo <- function() { struct(list(), "foo") }
  expect_error(range_safe("a", 1), class = "factRangeNumericError")
  expect_error(range_safe(1, Sys.Date()), class = "factRangeDateError")
  # because I don't know what to do about these
  expect_error(range_safe(foo(), foo()), class = "factRangeTypesError")

  expect_error(range_safe(NA_integer_, 1L), class = "factRangeFiniteError")
  expect_error(range_safe(Inf, 1L), class = "factRangeFiniteError")
})
