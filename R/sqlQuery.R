sqlQuery <- function(channel, query, ...) {
  # Check if the user is on a Mac
  
  if (Sys.info()[1] == "Darwin") {
    require(RMySQL)
    
    con <- dbConnect("MySQL", host = "172.28.48.6", user = "cpw", password = "cpw.123", dbname = "alex")
    
    return(dbGetQuery(con, query))
  } else {
    require(RODBC)
    return(RODBC::sqlQuery(channel, query, ...))
  }
}
