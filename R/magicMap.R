#' Plot data on a world map
#' 
#' This is a simple wrapper function to \code{rworldmap} for easy plotting of global data.
#' @param x A data frame of data with at least one column of country identificator (i.e., names or ISO alpha codes) and one column of numerical data to visualise.
#' @param data.column The numeric column you wish to visualize.
#' @import rworldmap stringr
#' @export

magicMap <- function(x, data.column = NULL, ...) {
  if (is.null(data.column)) {stop("You must name the column containing the numeric data to plot.")}
  
  country.key <- magic:::guessISO(x)
  if (is.null(country.key)) {stop("I could not guess the column for country codes. Please make sure you have a column named 'country' or 'isoalpha2' in your data.")}
  
  if (country.key$type == "country") {
    x <- magic:::mergeISO(x, country.names = country.key$column)
    country.key$column <- "ISOalpha3"
    country.key$type <- "ISO3"
  }
  
  country.data <- rworldmap::joinCountryData2Map(x, joinCode = country.key$type, nameJoinColumn=country.key$column)
  rworldmap::mapCountryData(country.data, nameColumnToPlot = data.column, ...)
}

locateCountryCols <- function(x) {
  cols <- names(x)
  # Match column names to a list of probable names
  regex <- c("((N|n)ame|(C|c)ountry|(C|c)ountries|(C|c)ountry(.|)(C|c)ode|(iso|ISO)(.|)(A|a)lpha(.|)(2|3)|(iso|ISO)(.|)(2|3))")
  hits <- cols[stringr::str_detect(cols, regex)]
  if (identical(hits, character(0))) {return(NULL)} # Return NULL for no hits
  return(hits)
}

getCountryColWidths <- function(x) {
  # Determine if data in a prospective country id column is ISO2, ISO3, or country names
  # by measuring the maximum character length of the column
  hits <- magic:::locateCountryCols(x)
  if (is.null(hits)) {stop("Could not guess country names.")}
  candidates <- data.frame(col = hits, chars = NA_integer_, stringsAsFactors = F)
  for (i in 1:nrow(candidates)) {
    thisCol <- as.character(candidates[i, "col"])
    col.data <- x[, thisCol]
    if (class(col.data) == "factor") {col.data <- as.character(col.data)}
    
    char.width <- try(max(nchar(col.data)), silent = T)
    
    if (class(char.width) == "try-error") {
      candidates[i, "chars"] <- 0
    } else {
      candidates[i, "chars"] <- char.width
    }
    
  }
  return(candidates)
}

guessISO <- function(x) {
  # Return a list of the most likely country ID column and best guess at content type (ISO2, ISO3, or country name)
  poss.cols <- subset(magic:::getCountryColWidths(x), chars == max(chars))
  o <- list(column = poss.cols$col)
  if (poss.cols$chars == 0) {
    o$type <- "country"
  }
  if (poss.cols$chars == 2) {
    o$type <- "ISO2"
  }
  if (poss.cols$chars == 3) {
    o$type <- "ISO3"
  }
  return(o)
}

mergeISO <- function(x, country.names = NULL) {
  # Merge ISO data based on spelled-out country name.
  # Probably very brittle, as even a single character difference will break the results.
  isos <- magicSQL("SELECT name, ISOalpha2, ISOalpha3 FROM countries", "cpw_meta")
  x <- merge(x, isos, by.x = country.names, by.y = "name")
  return(x)
}
