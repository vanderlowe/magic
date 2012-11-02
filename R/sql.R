#' Execute SQL query on CPW Lab's database server
#'
#' Create a database connection, select a database, and run a query in one line.
#' If neither database nor query is given, returns the list of available databases.
#' @details
#' This function assumes that you have a working ODBC
#' Data Source Name called 'azure' that points to 
#' CPW Lab's database server. The function uses RODBC package
#' to establish a database connection and executes the given
#' query on the given database.
#' If only one column is returned, it is converted to a vector.
#' 
#' @param database A text string that a valid database name on the CPW Lab's server. Blank by default.}
#' @param query A text string that can be evaluated as a valid SQL statement. By default, a command to show available databases.}
#' @param dsn A text string that matches a Data Source Name on the local system.}
#' @keywords manip
#' @export
#' @examples
#' sql("iOpener", "SHOW TABLES;")  # Show available tables in iOpener database.
#' sql("MyPersonality", "SELECT gender, age FROM user_dict")  # Select gender and age from user dictionary

sql <- function(database = "", query = "SHOW DATABASES;", dsn = "azure") {
  
  lib <- require("RODBC")
  if (!lib) {stop("You must have package 'RODBC' installed.")}
	if (is.null(query)) {stop("You must specify an SQL query")}

	# Create database connection
	db <- odbcConnect(dsn)
	sqlQuery(db, sprintf("USE %s;", database))

	# Execute query
	result <- sqlQuery(db, query)
  
  # Reduce 1-column data.frames to vectors
  if (class(result) == "data.frame") {
    if (ncol(result) == 1) {result <- result[,1]}
  }
  
	# Close unused connection
	odbcClose(db)
	rm(db)  # Keeping the environment neat :)

	return(result)
}
