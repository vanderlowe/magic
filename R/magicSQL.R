#' Interact with Cambridge Prosociality and Well-Being Lab's MySQL databases
#'
#' This function allows execution of SQL on CPW Lab databases. Depending on the system, 
#' it chooses either RMySQL or RODBC package to execute the query (RMySQL for Macs, RODBC for Windows).
#'
#' @param query SQL query to be executed. Will default to "SHOW DATABASES;" if left empty.
#' @param db Name of the database on which the query is to be executed.
#' @keywords manip
#' @export
#' @examples
#' magicSQL()
#' magicSQL("SELECT * FROM iPPQ", "iOpener")

magicSQL <- function(query = NULL, db = NULL) {
  
  if (!is.null(query) & is.null(db)) {
    stop("Please select a database to execute the query. For a list of available databases, type 'magicSQL()'.")
  }
  if (is.null(query)) {query = "SHOW DATABASES;"}
  
  # Load connection details from environment variables
  magic_host <- Sys.getenv("magic_host")
  magic_user <- Sys.getenv("magic_user")
  magic_password <- Sys.getenv("magic_password")
  
  # Check whether magicConfig needs to be run
  if (any(Sys.getenv("magic_host") == "", Sys.getenv("magic_user") == "", Sys.getenv("magic_password") == "")) {
    message("Your access credentials have not yet been set...")
    magicConfig()
  }
  
  # Check whether the user is on a Windows or Mac system
  # This is needed, because Mac users will connect via RMySQL
  # and Windows users via RODBC
  if (Sys.info()[1] == "Darwin") {
    # Code for Mac users
    require(RMySQL)
    con <- dbConnect("MySQL", host = magic_host, user = magic_user, password = magic_password, dbname = db)
    results <- dbGetQuery(con, query)
    
    # Remove system databases from null query results
    if (query == "SHOW DATABASES;") {
     results <- data.frame(Database = results[!results$Database %in% c("information_schema", "mysql", "cpw_Originals"),])
    }
    
    dbDisconnect(con)
    return(results)
    
  } else {
    # PC code in here
    require(RODBC)
    
    channel <- odbcConnect("UnifiedServer")
    
    # Check whether db was defined; if yes, use the given database
    if (!is.null(db)) {
      sqlQuery(channel, sprintf("USE %s;", db))
    }
    
    results <- sqlQuery(channel, query)
    
    # Remove system databases from null query results
    if (query == "SHOW DATABASES;") {
      results <- data.frame(Database = results[!results$Database %in% c("information_schema", "mysql", "cpw_Originals"),])
    }
    
    odbcClose(channel)
    return(results)
  }
  
}

