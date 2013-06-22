\name{magicCite}
\alias{magicCite}
\title{Create a citation link between papers}
\usage{
  magicCite(from, to, sentence, section)
}
\arguments{
  \item{from}{The citekey for the current paper}

  \item{to}{The citekey for the paper being cited}

  \item{sentence}{The sentence in which the citation
  occurs. You can copy-paste it from the PDF you are
  reading.}
}
\value{
  TRUE if insertion was successful
}
\description{
  This function creates a citation link between a paper you
  are currently reading and an in-text citation to an
  external paper.
}

