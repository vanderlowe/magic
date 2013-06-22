#' Get citation network
#' 
#' This function returns an \code{igraph} network object.
#' @export
#' @import igraph
magicCitationNetwork <- function(user = NULL, prune = 0) {
  if (is.null(user)) {
    users.cit <- magicSQL("SELECT DISTINCT(user) FROM citations", "cpw_litReview")$user
    users.pap <- magicSQL("SELECT DISTINCT(user) FROM papers", "cpw_litReview")$user
    users <- unique(c(users.cit, users.pap))
  }
  
  citations <- magicSQL(sprintf("SELECT `from`, `to`, `section` FROM citations WHERE user IN ('%s')", paste(users, collapse = "','")), "cpw_litReview")
  papers <- magicSQL("SELECT `citekey`, COUNT(`to`) as degree
                      FROM   papers p 
                      LEFT JOIN citations c
                      ON p.citekey = c.to
                      GROUP BY citekey
                      ORDER BY degree DESC", 
                     "cpw_litReview"
                     )
  
  prune.papers <- c(
    subset(papers, degree <= prune)$citekey
  )
  
  papers <- subset(papers, degree <= prune)
  citations <- subset(citations, from %in% prune.papers | to %in% prune.papers)
  
  g <- igraph::graph.data.frame(citations, directed = T, vertices = papers)
  return(g)
}