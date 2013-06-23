#' Visual map of literature
#' 
#' This function queries the \code{cpw_litReview} to visualize a citation network between the papers in the database.
#' @export
#' @import igraph
#' @param user Optional vector of user names to filter citations based on who contributed them into the database.
magicOverview <- function(user = NULL, simplify = TRUE) {
  g <- magicCitationNetwork(user = user)
  if (simplify) {
    # Remove nodes with no edges
    new_g <- delete.vertices(g, which(degree(g) < 1)-1)
  }
  
  prettyNetwork(g)
}

prettyNetwork <- function(g) {
  igraph::plot.igraph(g,
                      layout = layout.fruchterman.reingold,
                      vertex.size = 0,
                      vertex.color = NA,
                      vertex.frame.color = NA,
                      vertex.label = V(g)$name,
                      vertex.label.cex = 0.5,
                      vertex.label.family = "sans",
                      vertex.label.dist = 0.1,
                      edge.color = factor(E(g)$section),
                      edge.arrow.size = 0.1,
                      edge.arrow.width = 0.1,
                      edge.curved = F
                      )
}