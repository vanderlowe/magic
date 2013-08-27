\name{magicExplainTable}
\alias{magicExplainTable}
\title{Get overview of a database table variables}
\usage{
  magicExplainTable(table = NULL, db = NULL)
}
\arguments{
  \item{table}{The name of the table that contains the
  variables of interest.}

  \item{db}{The name of the database that contains the
  table of interest.}
}
\value{
  A data frame of variable names and descriptions. Best
  assigned to an object and viewed in RStudio.
}
\description{
  This function produces a summary of variable descriptions
  in a given database table.
}
\examples{
\dontrun{
magicExplainTable(table = "consumer_survey", db = "cpw_OpenSource)
vars <- magicExplainTable(table = "consumer_survey", db = "cpw_OpenSource)
View(vars)
}
}
\keyword{manip}

