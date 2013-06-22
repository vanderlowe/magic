test_that("ISO2 conversion returns sensible responses", {
  expect_equal(class(iso2("US")), "character")
  expect_equal(
    c(nchar(iso2("US")), nchar(iso2("USA")), nchar(iso2("United States"))), 
    c(2,2,2)
  )
  expect_equal(iso2("NA"), "NA")  # Returns itself, it two chars long
  expect_equal(iso2("NAM"), "NA")
  expect_equal(iso2("Namibia"), "NA")
  expect_error(iso2(NA))
  expect_error(iso2())
  
})

test_that("iso2 validation works", {
  expect_equal(verifyISO2("XX"), NULL)
  expect_error(verifyISO2())
  expect_equal(verifyISO2("US"), "US")
})

test_that("ISO3 conversion returns sensible responses", {
  expect_equal(class(iso3("USA")), "character")
  expect_equal(
    c(nchar(iso3("US")), nchar(iso3("USA")), nchar(iso3("United States"))), 
    c(3,3,3)
  )
  expect_equal(iso3("FJI"), "FJI")  # Returns itself, it two chars long
  expect_equal(iso3("NA"), "NAM")
  expect_equal(iso3("Namibia"), "NAM")
  expect_error(iso3(NA))
  expect_error(iso3())
  
})

test_that("iso3 validation works", {
  expect_equal(verifyISO3("XX"), NULL)
  expect_error(verifyISO3())
  expect_equal(verifyISO3("US"), "US")
})