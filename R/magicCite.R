#' Create a citation link between papers
#' 
#' This function creates a citation link between a paper you are currently reading and an in-text citation to an external paper.
#' @return TRUE if insertion was successful
#' @param from The citekey for the current paper
#' @param to The citekey for the paper being cited
#' @param sentence The sentence in which the citation occurs. You can copy-paste it from the PDF you are reading.
#' @export
#' 
magicCite <- function(from, to, sentence, section) {
  if (missing(from)) {
    stop("You must provide a citekey for the paper you are currently reading.")
  }
  
  if (missing(to)) {
    stop("You must provide a citekey for the paper being cited.")
  }
  
  if (missing(sentence)) {
    stop("You must provide a sentence in which the citation occurs. Copy-paste it from the PDF.")
  }
  
  if (from %in% c("", NA, character(0))) {
    stop("Citekey of the source document cannot be blank.")
  }
  
  if (!is.null(to)) {
    if (to %in% c("", NA, character(0))) {
      stop("Citekey of the target document cannot be blank.")
    }
    
    if (!magic:::citekeyExists(to, verbose = F)) {
      magicPaper(to)  # Create target paper, if it does not already exist.
    }
  }
  
  if (sentence %in% c("", NA, character(0))) {
    stop("The citation sentence cannot be blank.")
  }
  
  sentence <- gsub("'", "\\'\\'", sentence)
  
  if (!magic:::citekeyExists(from, verbose = F)) {
    stop("You must create the source paper first. Use magicPaper().")
  }
  
  if (missing(section)) {
    section <- "NULL"
  } else {
    if (!section %in% c("i", "m", "r", "d")) {
      stop("Section must be one of the following characters: i, m, r, d (first characters of Introduction, Method, Results, or Discussion.")
    }
    section <- paste("'", section, "'", collapse = "", sep = "")  # Enclose in single quotes
  }
  
  from <- tolower(from)
  
  if (is.null(to)) {
    to <- "NULL"
  } else {
    to <- paste("'", tolower(to), "'", sep = "", collapse = "")
  }
  
  section <- tolower(section)
  
  sql <- sprintf("INSERT INTO `citations` (`from`, `to`, `sentence`, `section`, `user`)
                  VALUES ('%s', %s, '%s', %s, '%s', %i)",
                 from, to, sentence, section, Sys.getenv('magic_user')
                 )
  magicSQL(sql, "cpw_litReview")
  return(TRUE)
}
