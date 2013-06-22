#' Show what others have said about a paper
#' 
#' This function prints sentences that authors have used in reference to the focal paper. In many ways, these sentences summarize important points about it.
#' @export
#' @import magic stringr
#' @param citekey The citation key of the paper to be summarized.
#' @return A vector of sentences
magicSynopsis <- function(citekey) {
  cites <- magicSQL(sprintf("SELECT `sentence`, `from` FROM `citations` WHERE `to` = '%s' ORDER BY `created`", tolower(citekey)), "cpw_litReview")
  if (length(cites$sentence) > 0) {
    for (citer in unique(cites$from)) {
      thisCite <- subset(cites, from == citer)
      cat(citer, sprintf("[cited %i time(s)]:\n", nrow(thisCite)))
      cat(paste(gsub("(\\n+|-[ \\s\\n]+)", "", thisCite$sentence), collapse = " "))
      cat("\n\n")
    }
  }
  
  refs <- magicSQL(sprintf("SELECT `to` AS Reference, COUNT(`to`) AS times_cited FROM `citations` WHERE `from` = '%s' GROUP BY `to`", tolower(citekey)), "cpw_litReview")
  if (nrow(refs) > 0) {
    refs <- refs[order(refs$times_cited, decreasing = T), ]
    refs <- subset(refs, times_cited > 1)
    row.count <- nrow(refs)
    if (row.count > 10) {
      row.count <- 10
    }
    popular <- refs[seq(1, row.count), ]
    
    cat(sprintf("Most frequently cited articles in %s:\n", citekey))
    for (i in 1:row.count) {
      cat(i, ") ", as.character(popular[i, "Reference"]), " (", as.character(popular[i, "times_cited"]), " times)\n", sep = "")
    } 
  }
  
  # Calculate keywords
  word.vector <- unlist(strsplit(paste(cites$sentence), "\\W+", perl=TRUE))
  word.freq <- sort(table(word.vector), decreasing = T)
  keywords <- data.frame(keyword = tolower(names(word.freq)), count = word.freq)
  rownames(keywords) <- NULL
  
  # Drop years
  keywords <- keywords[!str_detect(keywords$keyword, "\\d{4}"), ]
  
  # Drop words that are too frequent in English to be good keywords  
  stopwords <- c("a", "an", "the", "of", "e", "g", "is", "et", "al", "have", "has", "that",
                 "and", "as", "to", "for", "about", "are", "be", "am", "also", "at", "from",
                 "by", "can", "do", "if", "in", "into", "it", "no", "not", "on", "any", "or",
                 "than", "p", ">", "=", "f", "t", "that", "then", "there", "this", "was", "were",
                 "what", "when", "why", "where", "which", "who", "will", "with", "one", "two", "three",
                 "four", "five", "six", "seven", "eight", "nine", "ten")
  
  author <- gsub("\\d{4}(|.+)$", "", citekey)  # Drop author name
  
  keywords <- keywords[!keywords$keyword %in% c(stopwords, author), ]
  
  keywords <- subset(keywords, count > 3)  # Only keep commonly used words
  
  if (nrow(keywords) > 0) {
    cat(sprintf("Most frequent citation words %s:\n", citekey))
    cat(paste(as.character(keywords$keyword), collapse = ", "), "\n")
  }
  
  # Return above data invisibly (for assignment to a variable)
  invisible(list(citations = cites, references = popular, keywords = keywords))
}
