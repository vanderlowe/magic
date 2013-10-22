#' \code{magic} configuration utility
#' 
#' Stores access credentials into environment variables for frictionless data access.
#' @param user Your CPW Lab user name
#' @param password Your CPW Lab password
#' @param save.to.file Do not use this function on a public access computer! It writes the unencrypted user name and password to a file for later use. If you save your access credentials to disk, you must maintain physical possession of your computer at all times and notify CPW Lab management if you lose a computer with saved access credentials.
#' @export
#' @note Because the function writes your user and password into Rprofile file, make sure that unauthorized people do not have access to your computer.
#' 
magicConfig <- function(user = NULL, password = NULL, save.to.file = F) {
  
  if (interactive()) {
    # R is running in interactive mode.
    # First, set host
    Sys.setenv(magic_host = 'koganserver001.psychol.cam.ac.uk')
        
    # If user name is provided as an argument, use it.
    if (!is.null(user)) {
      Sys.setenv("magic_user" = user)
    } else {
      # If not, ask for it.
      uid <- readline("Please enter your user name: ")
      Sys.setenv("magic_user" = uid)
    }
    # If password is provided as an argument, use it.
    if (!is.null(password)) {
      Sys.setenv("magic_password" = password)
    } else {
      # If not, ask for it.
      pwd <- readline("Please enter your password: ")
      Sys.setenv("magic_password" = pwd)
    }
  } else {
    # Nothing to do in non-interactive sessions
    return(NULL)
  }
  
  if (save.to.file) {
    
    config.data <- c("message('Loading magic settings...')",
                     "Sys.setenv(magic_host = 'koganserver001.psychol.cam.ac.uk')",
                     sprintf("Sys.setenv(magic_user = '%s')", Sys.getenv("magic_user")),
                     sprintf("Sys.setenv(magic_password = '%s')", Sys.getenv("magic_password")), "")
    
    # Check if profile file exists
    profile.file <- paste(Sys.getenv("R_HOME"), "/etc/Rprofile.site", sep = "")
    if (file.exists(profile.file)) {
      message("Rprofile.site file exists already; appending.")
    } else {
      file.create(profile.file)
    }
    
    # Save configuration data to file
    message("Access credentials stored to disk. Please do not lose this computer or allow unauthorized access to it.")
    cat(paste(config.data, collapse = "\n"), file = profile.file, append = TRUE)
  }
}
