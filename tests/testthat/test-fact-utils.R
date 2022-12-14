test_that("`fact_levels<-`()", {
  x <- fact(1:3)
  fact_levels(x) <- 1:4
  exp <- struct(
    1:3,
    class = c("fact", "factor", "vctrs_vctr"),
    values = 1:4,
    levels = as.character(1:4),
    na = 0L
  )
  expect_identical(x, exp)
})

test_that("fact_coerce_levels()", {
  x <- as.Date("2021-09-03") + 0:2
  expect_equal(fact_coerce_levels(as.character(x)), x)

  # Be careful about setting a time zone
  # Not very good for dealing with local
  # NOTE r-dev after 4.2.1 has some weird behavior with the 0 and returns:
  #  ('2021-09-03', '2021-09-03 00:00:01', '2021-09-03 00:00:02')
  x <- as.POSIXlt("2021-09-03", tz = "UTC") + 1:3
  expect_equal(fact_coerce_levels(as.character(x)), x)

  x <- as.POSIXlt("2021-09-03", tz = "UTC") + 1:3
  expect_equal(fact_coerce_levels(as.character(x)), x)

  exp <- c(1.1, 2.0, NA)
  obj <- fact_coerce_levels(as.character(exp))
  expect_equal(obj, exp)
})

test_that("fact_na_label()", {
  expect_error(fact_na_label(1:2), class = "factNaLabelError")
})

test_that("try_numeric()", {
  x <- 1
  expect_identical(try_numeric(x), x)

  x <- c(NA, NA)
  expect_identical(try_numeric(x), x)

  x <- c("a", 1)
  expect_identical(try_numeric(x), x)

  x <- c(1, NA, 2)
  expect_identical(try_numeric(as.character(x)), x)
})

test_that("check_fact()", {
  expect_true(is.fact(new_fact()))
  expect_true(is_fact(new_fact()))

  expect_no_error(check_fact(new_fact()))
  expect_error(check_fact(struct(NULL, "foo")), class = "factNaClassError")
})
