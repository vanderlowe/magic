#' Explanations by \code{magic}
#'
#' This function explains a lot of things.
#'
#' @keywords manip
#' @export
#' @examples
#' magicExplain()
#' magicExplain("s002")

magicExplain <- function(obj, alpha = 0.05) {
  UseMethod("magicExplain")
}

print.magic <- function(x) {
  print(x$magicExplain)
}

magicExplain.NULL <- function() {
  message('Try giving magicExplain() a variable name within quotes as an argument (e.g., magicExplain("s002").')
}

magicExplain.character <- function(variable.name = NULL, database = NULL) {
  
  # Check whether user gave the necessary information 
  if (is.null(variable.name)) {
    stop("You must specify a variable name.")
  }
  
  # Check whether a variable can be found
  locate.sql <- sprintf("SELECT * FROM cpw_meta.variables WHERE Name LIKE '%s'", variable.name)
  
  if (!is.null(database)) {
    locate.sql <- paste(locate.sql, sprintf("AND `Database` = '%s'", database))
  }
  
  variables <- magicSQL(locate.sql, "cpw_meta")
  
  if (nrow(variables) == 0) {
    message("I am sorry, I could not find any variable matching by that name.\nPlease check you typed the variable name correctly.")
    return(invisible(NULL))
  }
  
  class(variables) <- c("magicMetaVariables",class(variables))
  return(variables)
}

print.magicMetaVariables <- function(x) {
  # Print detailed explanation for perfect hits (i.e., only one result)
  if (nrow(x) == 1) {
    message(sprintf("The variable '%s' is located in the '%s' table of '%s' database.", x$Name, x$Table, x$Database))
    message(sprintf("It has been described as '%s'.", x$Description))
    message("It can have the following values:")
    
    # Query values and labels associated with the variable
    values <- magicSQL(sprintf("SELECT Code as Value, Label FROM cpw_meta.responseOptions WHERE ID = %i ORDER BY Value", x$ID), "cpw_meta")
    for (i in 1:nrow(values)) {
      row <- values[i,]
      message(sprintf("%s = %s", row$Value, row$Label))
    }
  } else {
    # Print a summary of all hits
    print.data.frame(x)
  }
  
}
