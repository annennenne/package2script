#' @title Produce R script with package source code
#'
#' @param package Name of the package.
#' @param file Path for the output file. Must be of type R-script (.R). Default name is
#' the name of the package.
#' @param source Where to find the package? As of now, only "local" is implemented,
#' corresponding to the package source code being available on the local machine.
#' @param replace Should an already existing version of the produced R script be replaced?
#' Defaults to `FALSE` (no).
#' @param directory Path to the directory in which the source code for the package in located.
#' Defaults to the parent directory of the current directory.
#'
#'
#'
#' @import desc
#'
#' @export
package2script <- function(package, file = NULL, source = "local", replace = FALSE,
                           directory = "..") {
  #check if depends on cpp/byte-compiled/whatever that might be an issue

  if (is.null(file)) {
    file = paste(package, ".R", sep = "")
  }

  if (!replace & file.exists(file)) {
    stop(paste("The file", file, "is already in use.",
    "If you want to replace the file, use package2script with argument replace = TRUE"))
  }

  dir <- paste(directory, "/", package, sep = "")

  fileCon <- file(file, "w")

  thisDesc <- description$new(dir)

 # if (is.null(thisDesc$get_collate())) {
#    set_collate()
#  }

  allScripts <- thisDesc$get_collate()

  #add library() calls
  packages <- gsub("\\(.*\\)$", "", gsub(" ", "", strsplit(thisDesc$get_field("Imports"), ",\n")[[1]]))

  writeLines(paste(paste("library(", packages, ")", sep = ""), collapse = "\n "), fileCon)

  for (script in allScripts) {
    thisCon <- file(paste(directory, "/", package, "/R/", script, sep = ""))
    thisScript <- readLines(thisCon, warn = FALSE)
    close(thisCon)
    writeLines(thisScript, fileCon)
  }

  close(fileCon)

#  if (open) pander::openFileInOS(file)
}

