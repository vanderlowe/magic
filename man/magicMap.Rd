\name{magicMap}
\alias{magicMap}
\title{Plot data on a world map}
\usage{
  magicMap(x, data.column = NULL, ...)
}
\arguments{
  \item{x}{A data frame of data with at least one column of
  country identificator (i.e., names or ISO alpha codes)
  and one column of numerical data to visualise.}

  \item{data.column}{The numeric column you wish to
  visualize.}
}
\description{
  This is a simple wrapper function to \code{rworldmap} for
  easy plotting of global data.
}

