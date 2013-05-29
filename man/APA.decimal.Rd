\name{APA.decimal}
\alias{APA.decimal}
\title{Round numeric values to two decimal places}
\usage{
  APA.decimal(x, no.zero = F)
}
\arguments{
  \item{x}{Any numeric value}
}
\value{
  A string
}
\description{
  APA style requires that most statistics are reported to
  two decimal places. This function converts numeric input
  to strings with two decimal places.
}
\examples{
APA.decimal(0)
}

