test_that("format.pseudo_id()", {
  expect_snapshot(format(pseudo_id(c(0, 2, 1, 2, 1))))
  expect_snapshot(format(pseudo_id(list(a = 1:2, b = 1:3, c = 1:2))))
})

test_that("pillar_shaft.pseudo_id()", {
  expect_no_error(pillar_shaft(pseudo_id(1)))
})
