sql <- function(database = NULL, query = NULL, dsn = "azure", driver = "MySQL") {
	# This function assumes that you have set a dsn named 'azure' and installed ODBC drivers for MySQL
	if (is.null(database)) {stop("You must specify which database you want to use.")}
	if (is.null(query)) {stop("You must specify an SQL query")}

	# Create connection string
	connection.string = sprintf("driver={%s};dsn={%s};database={%s}", driver, dsn, database)

	# Create database connection
	db <- odbcDriverConnect(connection.string)

	# Execute query
	result <- sqlQuery(db, query)

	# Close unused connection
	odbcClose(db)
	rm(db)  # Keeping the environment neat :)

	return(result)
}
