\name{magicConfig}
\alias{magicConfig}
\title{\code{magic} configuration utility}
\usage{
  magicConfig(user = NULL, password = NULL,
    save.to.file = F)
}
\arguments{
  \item{user}{Your CPW Lab user name}

  \item{password}{Your CPW Lab password}

  \item{save.to.file}{Do not use this function on a public
  access computer! It writes the unencrypted user name and
  password to a file for later use. If you save your access
  credentials to disk, you must maintain physical
  possession of your computer at all times and notify CPW
  Lab management if you lose a computer with saved access
  credentials.}
}
\description{
  Stores access credentials into environment variables for
  frictionless data access.
}
\note{
  Because the function writes your user and password into
  Rprofile file, make sure that unauthorized people do not
  have access to your computer.
}

