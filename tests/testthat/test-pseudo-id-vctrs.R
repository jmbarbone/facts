pid <- new_pseudo_id()

test_that("vec_ptype_abbr()", {
  expect_identical(vec_ptype_abbr(pid), "pid")
})

test_that("vec_ptype2()", {
  expect_identical(vec_ptype2(pid, pid), pid)
  expect_identical(vec_ptype2(pid,         integer()  ), integer()  )
  expect_identical(vec_ptype2(integer(),   pid        ), integer()  )
  expect_identical(vec_ptype2(pid,         double()   ), double()   )
  expect_identical(vec_ptype2(double(),    pid        ), double()   )
  expect_identical(vec_ptype2(pid,         numeric()  ), numeric()  )
  expect_identical(vec_ptype2(numeric(),   pid        ), numeric()  )
  expect_identical(vec_ptype2(pid,         character()), character())
  expect_identical(vec_ptype2(character(), pid        ), character())
  expect_identical(vec_ptype2(pid,         new_date() ), new_date() )
  expect_identical(vec_ptype2(new_date(),  pid        ), new_date() )
  expect_identical(vec_ptype2(pid,         logical()  ), logical()  )
  expect_identical(vec_ptype2(logical(),   pid        ), logical()  )

  expect_identical(vec_ptype2(pid, pid),   pid)

  chrid <- pseudo_id(character())
  expect_identical(vec_ptype2(chrid, factor()), chrid)
  expect_error(vec_ptype2(pseudo_id(1L), factor(1L)), class = "vctrs_error_incompatible_type")
})

test_that("vec_cast.class.pseudo_id()", {
  expect_identical(vec_cast(pid, integer()),  integer())
  expect_identical(vec_cast(pid, double()),   double())
  expect_identical(vec_cast(pid, numeric()),  numeric())

  # a few errors
  expect_error(vec_cast(pid, character()), class = "vctrs_error_incompatible_type")
  expect_error(vec_cast(pid, factor()), class = "vctrs_error_incompatible_type")
  expect_error(vec_cast(pid, .Date(0)), class = "vctrs_error_incompatible_type")
})

test_that("vec_class.pseudo_id.integer()", {
  obj <- vec_cast(integer(), pid)
  exp <- new_pseudo_id()
  expect_identical(obj, exp)

  obj <- vec_cast(1:3, pid)
  exp <- pseudo_id(1:3)
  expect_identical(obj, exp)

  x <- c(2L, 1L, 3L)
  obj <- vec_cast(x, pid)
  exp <- pseudo_id(x)
  expect_identical(obj, exp)
})

test_that("vec_class.pseudo_id.double()", {
  dpid <- pseudo_id(double())

  obj <- vec_cast(double(), dpid)
  expect_identical(obj, dpid)

  x <- c(1, 2, 3)
  obj <- vec_cast(x, dpid)
  exp <- pseudo_id(x)
  expect_identical(obj, exp)

  x <- c(2, 1, 3)
  obj <- vec_cast(x, dpid)
  exp <- pseudo_id(x)
  expect_identical(obj, exp)
})

test_that("vec_class.pseudo_id.numeric()", {
  npid <- pseudo_id(numeric())

  obj <- vec_cast(numeric(), npid)
  expect_identical(obj, npid)

  x <- c(1, 2, 3)
  obj <- vec_cast(x, npid)
  exp <- pseudo_id(x)
  expect_identical(obj, exp)

  x <- c(2, 1, 3)
  obj <- vec_cast(x, npid)
  exp <- pseudo_id(x)
  expect_identical(obj, exp)
})

test_that("vec_class.pseudo_id.factor", {
  x <- c("b", "c", "a")
  p <- pseudo_id(x)
  f <- factor(x)
  expect_identical(vec_cast(f, p), p)

  x <- 1:3
  p <- pseudo_id(x)
  f <- factor(x)
  expect_error(vec_cast(f, p), class = "vctrs_error_incompatible_type")
})

test_that("as.integer.pseudo_id()", {
  x <- 1:3
  x <- as.integer(x)
  obj <- pseudo_id(x)
  obj <- as.integer(obj)
  expect_identical(obj, x)
})

test_that("as.double.pseudo_id()", {
  x <- 1:3
  x <- as.double(x)
  obj <- pseudo_id(x)
  obj <- as.double(obj)
  expect_identical(obj, x)
})

test_that("as.numeric.pseudo_id()", {
  x <- 1:3
  x <- as.numeric(x)
  obj <- pseudo_id(x)
  obj <- as.numeric(obj)
  expect_identical(obj, x)
})
