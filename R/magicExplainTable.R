#' Get overview of a database table variables
#'
#' This function produces a summary of variable descriptions in a given database table.
#'
#' @param table The name of the table that contains the variables of interest.
#' @param db The name of the database that contains the table of interest.
#' @keywords manip
#' @export
#' @examples
#' \dontrun{
#' magicExplainTable(table = "consumer_survey", db = "cpw_OpenSource)
#' }

magicExplainTable <- function(table = NULL, db = NULL) {
  if (is.null(table) | is.null(db)) {
    stop("Please provide both a table and database name.")
  }
  
  if (!inherits(table, "character") | !inherits(db, "character")) {
    stop("Table and database names must be character strings.")
  }
  
  sql <- sprintf("SELECT name, description FROM variables WHERE `table` = '%s' and `database` = '%s'", table, db)
  
  info <- magicSQL(sql, "cpw_meta")
  
  trim <- function(x) {gsub("^\\s+|\\s+$", "", x)}
  
  info$name <- trim(info$name)
  info$description <- trim(info$description)
  
  return(info)
  
}
