test_that("fact.default() fails", {
  expect_error(fact(struct(NULL, "foo")), class = "class_error")
})

test_that("fact.logical()", {
  x <- fact(c(TRUE, FALSE, NA))
  expect_no_message(expect_output(print(x)))

  obj <- fact(c(FALSE, NA, NA, TRUE, FALSE))
  res <- new_fact(
    c(2L, 1L, 1L, 3L, 2L),
    as.character(c(NA, FALSE, TRUE)),
    logical()
  )
  expect_identical(obj, res)
  expect_true(anyNA(obj))
})

test_that("fact.integer()", {
  obj <- fact(struct(1L, c("foo", "integer")))
  p <- structure(integer(0), class = c("foo", "integer"))
  exp <- new_fact(1L, "1", p)
  expect_equal(obj, exp)
})

test_that("fact.factor()", {
  # x <- fact(as.character(c(Sys.Date() + 5:1, NA))[sample(1:6, 20, TRUE)])

  x <- factor(letters)
  class(x) <- c("fact", "factor")
  expect_identical(fact(x), x)

  x <- ordered(letters)
  class(x) <- c("ordered", "fact", "factor", "vctrs_vctr")
  expect_identical(fact(x), x)

  x <- struct(1L, c("fact", "factor"), levels = c("a", NA_character_))
  expect_identical(fact(x), x)

  x <- factor(c(1, NA, 2))
  expect_identical(levels(fact(x)), c(NA, "1", "2"))
})
