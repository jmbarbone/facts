test_that("abbr", {
  f <- new_fact()
  obj <- vec_ptype_abbr(f)
  exp <- "fct<chr>"
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
