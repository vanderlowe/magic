sql <- function(database = NULL, query = NULL, dsn = "azure") {
  
  lib <- require("RODBC")
  if (!lib) {stop("You must have package 'RODBC' installed.")}
	
	if (is.null(database)) {stop("You must specify which database you want to use.")}
	if (is.null(query)) {stop("You must specify an SQL query")}

	# Create database connection
	db <- odbcConnect(dsn)
	sqlQuery(db, sprintf("USE %s;", database))

	# Execute query
	result <- sqlQuery(db, query)

	# Close unused connection
	odbcClose(db)
	rm(db)  # Keeping the environment neat :)

	return(result)
}
