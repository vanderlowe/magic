sql <- function(database = "", query = "SHOW DATABASES;", dsn = "azure") {
  
  lib <- require("RODBC")
  if (!lib) {stop("You must have package 'RODBC' installed.")}
	if (is.null(query)) {stop("You must specify an SQL query")}

	# Create database connection
	db <- odbcConnect(dsn)
	sqlQuery(db, sprintf("USE %s;", database))

	# Execute query
	result <- sqlQuery(db, query)
  if (ncol(result) == 1) {result <- result[,1]}

	# Close unused connection
	odbcClose(db)
	rm(db)  # Keeping the environment neat :)

	return(result)
}
