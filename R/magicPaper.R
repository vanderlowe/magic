#' Create a new article in the literature review database
#' 
#' Inserts new article data into the literature review database. The function does a basic check on whether the paper already exists.
#' @param citekey A unique identifier for the article in the format 'firstauthorfamilyname' + year (e.g., vanderlowe2013).
#' @param title Full title of the article (optional, but strongly recommended!)
#' @return TRUE on successful insertion
#' @import stringr
#' @export
#' 
magicPaper <- function(citekey, title, update = FALSE) {
  if (missing(citekey)) {
    stop("You must provide a citation key.")
  }
  
  if (citekey %in% c("", NA, character(0))) {
    stop("Citekey cannot be blank.")
  }
  
  citekey <- tolower(as.character(citekey))
  
  if (str_detect(citekey, "(\\d){5,}")) {
    stop("You have more than 4 numbers in the citekey.")
  }
  
  year <- as.numeric(str_extract(citekey, "\\d\\d\\d\\d"))
  
  if (is.na(year)) {
    stop("You must provide a year as part of the citekey!")
  }
  
  if (magic:::citekeyExists(citekey) & update == FALSE) {
    stop("The citation key was not unique. Please enter a different citekey (maybe add a letter after the year?). If you want to update an existing paper, use 'update = TRUE'.")
  }
  
  if (missing(title)) {
    title <- "NULL"
  } else {
    title <- gsub("'", "\\'\\'", title)
    title <- paste("'", title, "'", collapse = "", sep = "")  # Enclose in single quotes
  }
  
  if (update == FALSE) { # That is, we are creating a new paper...
    sql <- sprintf("INSERT INTO `papers` (`citekey`, `title`, `year`, `user`) 
                 VALUES ('%s', %s, %i, '%s')",
                   citekey, title, year, Sys.getenv('magic_user')
    )
    magicSQL(sql, "cpw_litReview")
  } else {  # That is, we are updating an existing one...
    sql <- sprintf("UPDATE `papers` 
                    SET `title` = %s, `year` = %i, `user` = '%s' 
                    WHERE citekey = '%s'",
                    title, year, Sys.getenv('magic_user'), citekey
    )
    magicSQL(sql, "cpw_litReview")
  }
  
  return(TRUE)
}

#' Function to check whether a paper is already in the database
citekeyExists <- function(citekey, verbose = T) {
  sql <- sprintf("SELECT citekey, title FROM papers WHERE citekey = '%s'", citekey)
  results <- magicSQL(sql, "cpw_litReview")
  if (nrow(results) > 0) {
    if (verbose) {
      msg <- sprintf("A paper %s '%s' already exists.", results$citekey, results$title)
      message(msg)
    }
    return(TRUE)
  }
  return(FALSE)
}
