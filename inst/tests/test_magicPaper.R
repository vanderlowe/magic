test_that("magicPaper behaves well", {
  
  expect_error( # if citekey is not provided
    magicPaper()
  )
  
  expect_error( # if citekey is zero length
    magicPaper("")
  )
  
  expect_error( # if year info is missing
    magicPaper("foobar")
  )
  
  expect_error( # if year info is missing
    magicPaper("foobar12345")
  )
  
  expect_error( # if year info is too short
    magicPaper("foobar123")
  )
})
