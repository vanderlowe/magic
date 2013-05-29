magicP <- function(i, sig.stars = F, p.notation = T) {
  i <- as.numeric(i)
  if (is.na(i)) {stop("Please provide numeric input.")}
    
  if (i < 0.001) {
    str = "0.001"
    prefix = "p < "
  } else {
    if (i < 0.01) {str = sprintf("%.3f", i)} else {str = sprintf("%.2f", i)}
    prefix = "p = "
  }
  
  if (p.notation) {
    str = paste(prefix, str, sep = "")
  }
  
  stars = ""
  if (sig.stars) {
    if (i <= 0.05) {stars = "*"}
    if (i <= 0.01) {stars = "**"}
    if (i <= 0.001) {stars = "***"}
  }
  
  str = gsub("0\\.",".", str)
  return(paste(str, stars, sep = ""))
}
