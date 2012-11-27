#' Find variables by descriptions
#'
#' This function finds variables included in the CPW Lab databases
#' based on text included in their descriptions. Currently, the search
#' is very greedy, so \code{language} would match the search text \code{age}.
#'
#' @param text A string that will be matched to variable descriptions.
#' @keywords manip
#' @export
#' @examples
#' magicFindVariable("country")  #
#' magicFindVariable("marriage")

magicFindVariable <- function(text = NULL) {
  
  if (is.null(text)) {
    stop("Please enter text as an argument. I will then find variables with matching descriptions.")
  }
  
  sql.cmd <- sprintf("SELECT `Name`, `Database`, `Table`, `Description` FROM cpw_meta.variables WHERE Description like '%%%s%%'", text)
  results <- magicSQL(sql.cmd, db = "cpw_meta")
  return(results)
}
