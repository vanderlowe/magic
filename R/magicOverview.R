#' Visual map of literature
#' 
#' This function queries the \code{cpw_litReview} to visualize a citation network between the papers in the database.
#' The line color indicates the section in which the citation was made: blue for introduction, green for methods, red for results, and gray for discussion. The lines are partially transparent, so color blends indicate citations in multiple sections.
#' @export
#' @import igraph
#' @param user Optional vector of user names to filter citations based on who contributed them into the database.
#' @param min.citations An integer to indicate how many times a paper has to be cited in order to be included in the graph (3 by default). Use 0 to plot the entire network as-is.
#' @return Nothing; plots a graph.
#' 
magicOverview <- function(user = NULL, min.citations = 3) {
  g <- magic:::magicCitationNetwork(user = user)
  if (min.citations > 0) {
    citers <- igraph:::V(igraph:::delete.vertices(g, which(igraph:::degree(g, mode = "out") < 1)))$name
    
    # Remove nodes with no edges
    g <- igraph:::delete.vertices(g, which(igraph:::degree(g, mode = "in") < min.citations & !igraph:::V(g)$name %in% citers))
  }
  
  magic:::prettyNetwork(g)
}

prettyNetwork <- function(g) {
  # The order for colors is: discussion (gray), intro (blue), methods (green), results (red)
  colors <- c("#CCCCCCBB", "#0000FFBB", "#00FF00BB", "#FF0000BB")
  igraph::plot.igraph(g,
                      layout = igraph:::layout.fruchterman.reingold,
                      vertex.size = 0,
                      vertex.color = NA,
                      vertex.frame.color = NA,
                      vertex.label = igraph:::V(g)$name,
                      vertex.label.cex = 0.6,
                      vertex.label.family = "sans",
                      vertex.label.dist = 0.1,
                      vertex.label.degree = -pi/2,
                      edge.width = 1.5,
                      edge.color = colors[factor(igraph:::E(g)$section)],
                      edge.arrow.size = 0.1,
                      edge.arrow.width = 0.1,
                      edge.curved = F
                      )
}