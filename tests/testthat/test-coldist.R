library(pavo)
context("coldist")

test_that("Errors", {
  data(flowers)

  expect_error(coldist(vismodel(flowers, relative = FALSE), n = c(1, 2, 3, 4, 5), achro = FALSE), "different length")
  expect_error(coldist(vismodel(flowers, relative = FALSE), n = c(1, 2, 3), achro = FALSE), "different length")
})

test_that("Equivalent", {
  data(flowers)

  expect_equal(
    coldist(vismodel(flowers, relative = FALSE), weber.ref = "longest", achro = FALSE),
    coldist(vismodel(flowers, relative = FALSE), weber.ref = 4, achro = FALSE)
  )

  expect_equal(
    coldist(vismodel(flowers, relative = FALSE), weber.ref = "longest", achro = FALSE),
    coldist(vismodel(flowers, relative = FALSE), weber.ref = 4, achro = FALSE)
  )

  expect_equal(
    coldist(vismodel(flowers, relative = FALSE), achro = FALSE),
    suppressWarnings(coldist(colspace(vismodel(flowers, relative = FALSE)), achro = FALSE)),
    check.attributes = FALSE
  )

  expect_equal(
    suppressWarnings(coldist(vismodel(flowers))),
    suppressWarnings(coldist(colspace(vismodel(flowers)))),
    check.attributes = FALSE
  )

  expect_equal(
    suppressWarnings(coldist(vismodel(flowers))),
    suppressWarnings(coldist(as.data.frame(vismodel(flowers)), qcatch = "Qi")),
    check.attributes = FALSE
  )
})

test_that("Options", {
  data(sicalis)

  expect_length(coldist(vismodel(sicalis, achromatic = "bt.dc", qcatch = "fi", relative = FALSE),
    noise = "quantum",
    achro = TRUE
  ), 4)
})
