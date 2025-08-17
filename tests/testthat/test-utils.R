test_that("is_integerish()", {
  expect_true(is_integerish(1L))
  expect_true(is_integerish(1))
  expect_true(is_integerish(NA_real_))

  expect_false(is_integerish("a"))
  expect_false(is_integerish(1.1))

  withr::local_options(list(facts.bool.integer = FALSE))
  expect_false(is_integerish(NA))
  expect_false(is_integerish(TRUE))

  withr::local_options(list(facts.bool.integer = TRUE))
  expect_true(is_integerish(NA))
  expect_true(is_integerish(TRUE))
})

test_that("values()", {
  expect_identical(values(factor("a")), "a")
  expect_identical(values(fact("a")), "a")

  expect_null(values("a", strict = TRUE))
  expect_identical(values("a", strict = FALSE), "a")
})
