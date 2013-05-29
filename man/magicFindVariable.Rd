\name{magicFindVariable}
\alias{magicFindVariable}
\title{Find variables by descriptions}
\usage{
  magicFindVariable(text = NULL)
}
\arguments{
  \item{text}{A string that will be matched to variable
  descriptions.}
}
\description{
  This function finds variables included in the CPW Lab
  databases based on text included in their descriptions.
  Currently, the search is very greedy, so \code{language}
  would match the search text \code{age}.
}
\examples{
magicFindVariable("country")  #
magicFindVariable("marriage")
}
\keyword{manip}

