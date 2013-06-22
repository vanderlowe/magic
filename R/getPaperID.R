#' Get paper ID from Microsoft Academic Search
#' 
#' This paper returns the ID of the best match for the search string
#' @param title The title of the paper
#' @return ID number
#' @import XML
#' 
getPaperID <- function(title) {
  title <- gsub("\\s","+", as.character(title))  
  results <- magic:::searchMASforPaper(title)
  id <- as.numeric(as.character(results[1, ]$ID))
  return(id)
}

getAPIkey <- function() {
  return(magicSQL("SELECT `key` FROM `API_keys` WHERE name = 'Microsoft Academic Research'", "cpw_meta")$key)
}

searchMASforPaper <- function(title) {
  url <- sprintf(
    "http://academic.research.microsoft.com/table.svc/search?AppId=%s&FullTextQuery=%s&ResultObjects=Publication&PublicationContent=AllInfo&StartIdx=1&EndIdx=10",
    magic:::getAPIkey(), title
  )
  return(MAStable(url))
}

getPaperByID <- function(id) {
  id <- as.numeric(id)
  url <- sprintf("http://academic.research.microsoft.com/table.svc/search?AppId=%s&PublicationID=%i&ResultObjects=Publication&ReferenceType=None&PublicationContentType=AllInfo&StartIdx=1&EndIdx=10&OrderBy=Year",
                 getAPIkey(), id
                 )
  return(MAStable(url))
}

MAStable <- function(url) {
  return(readHTMLTable(url, which = 1, header = T))
}

getPaperReferences <- function(id, n = 100) {
  id <- as.numeric(id)
  url <- sprintf("http://academic.research.microsoft.com/table.svc/search?AppId=%s&PublicationID=%i&ResultObjects=Publication&ReferenceType=Reference&StartIdx=1&EndIdx=%i&OrderBy=Year",
                 getAPIkey(), id, n
  )
  return(MAStable(url))
}
