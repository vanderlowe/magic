#' Get paper data through a query
#' 
#' This function returns the top result from Microsoft Academic Search for a given query.
#' @param query Preferably a unique paper title
#' @return paper data as a data.frame
#' @export
automagicPaper <- function(query, verbose = T) {
  paper <- getPaperByID(getPaperID(query))
  if (verbose) {
    message(sprintf("I found a paper titled '%s' (%s) by %s.\n",
                    as.character(paper$Title),
                    as.character(paper$Year),
                    as.character(paper$Author)
                    ))
    
      response <- tryCatch(
        readline("Should I use it (y/n)? "),
        error = function(e) { message(e) },
        finally = function(x) {x})  
    if (response == "y") {
      return(paper)
    } else {
      return(NULL)
    }
  }
  return(createMagicPaperFrom(paper))
}
