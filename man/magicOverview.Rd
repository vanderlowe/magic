\name{magicOverview}
\alias{magicOverview}
\title{Visual map of literature}
\usage{
  magicOverview(user = NULL, min.citations = 3)
}
\arguments{
  \item{user}{Optional vector of user names to filter
  citations based on who contributed them into the
  database.}

  \item{min.citations}{An integer to indicate how many
  times a paper has to be cited in order to be included in
  the graph (3 by default). Use 0 to plot the entire
  network as-is.}
}
\value{
  Nothing; plots a graph.
}
\description{
  This function queries the \code{cpw_litReview} to
  visualize a citation network between the papers in the
  database. The line color indicates the section in which
  the citation was made: blue for introduction, green for
  methods, red for results, and gray for discussion. The
  lines are partially transparent, so color blends indicate
  citations in multiple sections.
}

