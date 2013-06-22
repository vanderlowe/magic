\name{magicPaper}
\alias{magicPaper}
\title{Create a new article in the literature review database}
\usage{
  magicPaper(citekey, title, update = FALSE)
}
\arguments{
  \item{citekey}{A unique identifier for the article in the
  format 'firstauthorfamilyname' + year (e.g.,
  vanderlowe2013).}

  \item{title}{Full title of the article (optional, but
  strongly recommended!)}
}
\value{
  TRUE on successful insertion
}
\description{
  Inserts new article data into the literature review
  database. The function does a basic check on whether the
  paper already exists.
}

