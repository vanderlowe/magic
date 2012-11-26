\name{magicSQL}
\alias{magicSQL}
\title{Interact with Cambridge Prosociality and Well-Being Lab's MySQL databases}
\usage{
  magicSQL(query = NULL, db = NULL)
}
\arguments{
  \item{query}{SQL query to be executed. Will default to
  "SHOW DATABASES;" if left empty.}

  \item{db}{Name of the database on which the query is to
  be executed.}
}
\description{
  This function allows execution of SQL on CPW Lab
  databases. Depending on the system, it chooses either
  RMySQL or RODBC package to execute the query (RMySQL for
  Macs, RODBC for Windows).
}
\examples{
magicSQL()
magicSQL("SELECT * FROM iPPQ", "iOpener")
}
\keyword{manip}

