#' Get a list of all ISO 3166-1 alpha codes
#' 
#' Retrieve either ISO 3166-1 alpha-2 or alpha-3 codes from \code{cpw_meta.countries} table
#' @param iso.length Either values 2 or 3 to indicate which set of alpha codes to return.
#' @return A character vector of alpha codes
#' @export
#' 
getISOs <- function(iso.length) {
  if (iso.length %in% 2:3) {
    as.character(return(magicSQL(sprintf("SELECT ISOalpha%i FROM countries", iso.length), "cpw_meta")[,1]))
  } else {
    stop("Only 2 and 3 are valid arguments.")
  }
}

#' Get a valid country ISO2 alpha code
#' 
#' This function looks up ISO2 alpha country code from the \code{cpw_meta.countries} table.
#' @param country Either a valid country name, ISO2 alpha code, or ISO3 alpha code
#' @return Two-character ISO2 alpha country code
#' @export
#' 
iso2  <- function(country) {
  if (is.na(country) | is.null(country) | missing(country)) {
    stop("You must supply either a country name or numeric ISO code")
  }
  country <- as.character(country)
  if (nchar(country) ==  2) {return(verifyISO2(country))}
  if (nchar(country) ==  3) {return(getISO2byISO3(country))}
  if (nchar(country) >  3) {return(getISO2byName(country))}
  stop("You must provide a valid 2- or 3-letter ISO country code or a recognized country name.")
}

verifyISO2 <- function(code) {
  code <- as.character(code)
  sql <- sprintf("SELECT ISOalpha2 FROM countries WHERE ISOalpha2 = '%s'", code)
  hits <- magicSQL(sql, "cpw_meta")
  if (nrow(hits) == 0) {
    stop("Could not find country.")
  } else {
    if (nrow(hits) > 1) {stop("The code returns multiple countries.")}
    return(hits$ISOalpha2)
  }
}

getISO2byName <- function(country) {
  return(
    verifyISO2(as.character(magicSQL(sprintf("SELECT ISOalpha2 FROM countries WHERE name = '%s'", country), "cpw_meta")[,1]))
  )
}

getISO2byISO3 <- function(iso3) {
  return(
    verifyISO2(as.character(magicSQL(sprintf("SELECT ISOalpha2 FROM countries WHERE ISOalpha3 = '%s'", iso3), "cpw_meta")[,1]))
  )
}

#' Get a valid country ISO3 alpha code
#' 
#' This function looks up ISO3 alpha country code from the \code{cpw_meta} table.
#' @param country Either a valid country name, ISO2 alpha code, or ISO3 alpha code
#' @return Three-character ISO3 alpha country code
#' @export
#' 
iso3  <- function(country) {
  if (is.na(country) | is.null(country) | missing(country)) {
    stop("You must supply either a country name or numeric ISO code")
  }
  country <- as.character(country)
  if (nchar(country) ==  2) {return(getISO3byISO2(country))}
  if (nchar(country) ==  3) {return(verifyISO3(country))}
  if (nchar(country) >  3) {return(getISO3byName(country))}
  stop("You must provide a valid 2- or 3-letter ISO country code or a recognized country name.")
}

verifyISO3 <- function(code) {
  code <- as.character(code)
  sql <- sprintf("SELECT ISOalpha3 FROM countries WHERE ISOalpha3 = '%s'", code)
  hits <- magicSQL(sql, "cpw_meta")
  if (nrow(hits) == 0) {
    stop("Could not find country.")
  } else {
    if (nrow(hits) > 1) {stop("The code returns multiple countries.")}
    return(hits$ISOalpha3)
  }
}

getISO3byISO2 <- function(iso2) {
  return(
    as.character(magicSQL(sprintf("SELECT ISOalpha3 FROM countries WHERE ISOalpha2 = '%s'", iso2), "cpw_meta")[,1])
  )
}

getISO3byName <- function(country) {
  return(
    as.character(magicSQL(sprintf("SELECT ISOalpha3 FROM countries WHERE name = '%s'", country), "cpw_meta")[,1])
  )
}

#' Get full country name from ISO alpha codes
#' This function looks up fully spelled-out country name from the \code{cpw_meta} table using ISO alpha code.
#' @param iso Either a ISO2 or ISO3 alpha code
#' @return Country name as a string
#' @export
getCountryName <- function(iso.code) {
  iso.code <- as.character(iso.code)
  if (length(iso.code) > 1) {stop("Please provide only one country name.")}
  iso.length <- nchar(iso.code)
  
  if (iso.length %in% c(2,3)) {
    sql <- sprintf("SELECT name FROM countries WHERE ISOalpha%s = '%s'", iso.length, iso.code)
    return(magicSQL(sql, "cpw_meta")[, 1])
  } else {
    stop("ISO alpha code can only be 2 or 3 characters long.")
  }
}