\name{sql}
\alias{sql}
\title{Execute SQL query on Azure.}
\usage{sql(database = "", query = "SHOW DATABASES;", dsn = "azure")}

\description{
  Create a database connection, select a database, and run a query in one line.
  If neither database nor query is given, returns the list of available databases.
}

\details{
  This function assumes that you have a working ODBC
  Data Source Name called 'azure' that points to 
  CPW Lab's database server. The function uses RODBC package
  to establish a database connection and executes the given
  query on the given database.

  If only one column is returned, it is converted to a vector.
}
\keyword{}
\arguments{
  \item{database}{A text string that a valid database name on the CPW Lab's server. Blank by default.}
  \item{query}{A text string that can be evaluated as a valid SQL statement. By default, a command to show available databases.}
  \item{dsn}{A text string that matches a Data Source Name on the local system.}
}
\examples{
# Returns available databases.
sql()

# Show available tables in iOpener database.
sql("iOpener", "SHOW TABLES;")

# Select gender and age from user dictionary from MyPersonality database
sql("MyPersonality", "SELECT gender, age FROM user_dict")
}