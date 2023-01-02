test_that("vctrs support", {
  expect_error(
    vec_c(fact(integer()), "a"),
    class = "vctrs_error_incompatible_type"
  )
})
