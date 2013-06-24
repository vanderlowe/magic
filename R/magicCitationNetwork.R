#' Get citation network
#' 
#' This function returns an \code{igraph} network object.
#' @export
#' @import igraph
magicCitationNetwork <- function(user = NULL) {
  if (is.null(user)) {
    users.cit <- magicSQL("SELECT DISTINCT(user) FROM citations", "cpw_litReview")$user
    users.pap <- magicSQL("SELECT DISTINCT(user) FROM papers", "cpw_litReview")$user
  } else {
    users.cit <- magicSQL(sprintf("SELECT DISTINCT(user) FROM citations WHERE user IN ('%s')", paste(user, collapse = "', '")), "cpw_litReview")$user
    users.pap <- magicSQL(sprintf("SELECT DISTINCT(user) FROM papers WHERE user IN ('%s')", paste(user, collapse = "', '")), "cpw_litReview")$user
  }
  users <- unique(c(users.cit, users.pap))
  
  # Citations are edges in the network
  citations <- magicSQL(sprintf("SELECT `from`, `to`, `section` FROM citations WHERE user IN ('%s') AND `to` IS NOT NULL", paste(users, collapse = "','")), "cpw_litReview")
  
  # Papers are the network vertices
  papers <- magicSQL("SELECT `citekey`, COUNT(`to`) as degree
                      FROM   papers p 
                      LEFT JOIN citations c
                      ON p.citekey = c.to
                      GROUP BY citekey
                      ORDER BY degree DESC", 
                     "cpw_litReview"
                     )
  
  g <- igraph::graph.data.frame(citations, directed = T, vertices = papers)
  return(g)
}