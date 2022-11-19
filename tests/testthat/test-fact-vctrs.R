test_that("abbr", {
  f <- new_fact()
  obj <- vec_ptype_abbr(f)
  exp <- "fct"
  expect_identical(obj, exp)

  f <- new_fact(ordered = TRUE)
  obj <- vec_ptype_abbr(f)
  exp <- "fctor"
  expect_identical(obj, exp)
})

test_that("vec_c(fact)", {
  obj <- vec_c(fact("a"), fact("b"))
  exp <- fact(c("a", "b"))
  expect_identical(obj, exp)

  expect_error(
    vec_c(fact(1), fact("a")),
    class = "vctrs_error_incompatible_type"
  )
})

test_that("vec_c(character)", {
  obj <- vec_c(fact("a"), "b")
  exp <- c("a", "b")
  expect_identical(obj, exp)
})

test_that("vec_c(date)", {
  obj <- vec_c(fact(as.Date("2022-11-06")), as.Date("2020-11-06"))
  exp <- as.Date(c("2022-11-06", "2020-11-06"))
  expect_identical(obj, exp)
})

test_that("vec_c(factor)", {
  obj <- vec_c(fact("a"), factor("1"))
  exp <- fact(c("a", "1"))
  expect_identical(obj, exp)
})

test_that("vec_c(double)", {
  obj <- vec_c(fact(1.5), -2)
  exp <- c(1.5, -2)
  expect_identical(obj, exp)
})

test_that("vec_c(integer)", {
  obj <- vec_c(fact(1L), -2L)
  exp <- c(1L, -2L)
  expect_identical(obj, exp)
})

test_that("vec_c(logical)", {
  obj <- vec_c(fact(TRUE), FALSE)
  exp <- c(TRUE, FALSE)
  expect_identical(obj, exp)
})

test_that("vec_cast(character, fact)", {
  obj <- vec_cast(character(), new_fact(character()))
  expect_identical(obj, new_fact(character()))

  expect_error(
    vec_cast(character(), new_fact()),
    class = "vctrs_error_incompatible_type"
  )
})

test_that("vec_cast(fact, character)", {
  obj <- vec_cast(new_fact(), character())
  expect_identical(obj, character())
})

test_that("vec_cast(factor, fact)", {
  obj <- vec_cast(factor(), new_fact(character()))
  expect_identical(obj, new_fact(character()))

  expect_error(
    vec_cast(factor(), new_fact()),
    class = "vctrs_error_incompatible_type"
  )
})

test_that("vec_cast(fact, factor)", {
  obj <- vec_cast(new_fact(), factor())
  expect_identical(obj, factor())
})

test_that("vec_cast(numeric, fact)", {
  obj <- vec_cast(numeric(), new_fact(numeric()))
  expect_identical(obj, new_fact(numeric()))

  # numeric() okay for integers()
  expect_error(
    vec_cast(numeric(), new_fact()),
    NA
  )

  obj <- vec_cast(numeric(), new_fact())
  expect_identical(obj, new_fact(numeric()))
})

test_that("vec_cast(fact, numeric)", {
  obj <- vec_cast(new_fact(), numeric())
  expect_identical(obj, numeric())
})
