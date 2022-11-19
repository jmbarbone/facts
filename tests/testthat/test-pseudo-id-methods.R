test_that("format.pseudo_id()", {
  x <- pseudo_id(c(0, 2, 1, 2, 1))
  obj <- format(x)
  exp <- c("1 <0>", "2 <2>", "3 <1>", "2 <2>", "3 <1>")
  expect_identical(obj, exp)
})

test_that("pillar_shaft.pseudo_id()", {
  expect_no_error(pillar_shaft(pseudo_id(1)))
})
