#' Round numeric values to two decimal places
#' 
#' APA style requires that most statistics are reported to two decimal places. This function converts numeric input to strings with two decimal places.
#' @param x Any numeric value
#' @return A string
#' @examples
#' APA.decimal(0)
#' @export

APA.decimal <- function(x, no.zero = F) {
  x <- as.numeric(x)
  
  value = sprintf("%.2f", x)
  if (no.zero) {
    return(gsub("^0","", value))
  } else {
    return(print(value, digits = 3)) # Three significant digits
  }
}
