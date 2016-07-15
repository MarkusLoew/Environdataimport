#' Import a weather station file created by an Environdata weather station
#' 
#' @param file Filename of the csv file.
#' @return List with three name elements: Data with the actual data as data.frame, Parameter names and Units for each parameter. Grand totals, means etc provided in the Environdata file are currently discarded.
#' @examples 
#' \dontrun{
#' weather <- EnvironImport(myfile.csv)
#' head(weather$Data)
#' weather$Parameters
#' weather$Units
#' }

EnvironImport <- function(file) {
 # import the file, extract paramters names, units, and data
 # returns a list of data frame, paramter name, and units
 # first list-element is the data frame

   headers <- readLines(file)
   # identify rows with meta-data
   # meta-data start with ";"
   meta <- headers[grepl("^;", headers)]
   meta <- gsub("^;", "", meta)
   
   # identify the parameter names
   # parameter names start with "#"
   the.names <- headers[grepl("^#", headers)]
   # actual names are behind six spaces
   the.names <- unlist(lapply(strsplit(as.character(the.names), "      "), "[", 2)) 
   
   # Units are at the end of the parameter name in [] brackets
   the.units <- unlist(regmatches(the.names, gregexpr("\\[.*?\\]", the.names)))
   
   # Remove units from names
   the.names <- unlist(lapply(strsplit(as.character(the.names), "\\["), "[", 1))
   
   # There are two columns in the file that are not reflected in the parameter names: 
   # Date, and Time
   unnamed <- c("Date", "Time")
   the.names <- c(unnamed, the.names)
   the.units <- c(unnamed, the.units)
   
   # the hourly data file has duplicated parameter names
   # finding those and renaming them to avoid conflicts
   dups <- duplicated(the.names)
   the.names[dups == TRUE] <- paste(the.names[dups == TRUE], "1", sep = ".")
   
   # the data start after the last row with the word "Total"
   my.rows <- grepl("Total", headers)
   start.of.data <- max(which(my.rows))
   
   # End of data
   # the data end usually before the line with the words "\END OF DATA"
   # however, for corrupted files, there is only a "^M" carriage return,
   # indicating interrupted download of the file.
   # In that case, all remaining rows in the file are part of the data
   my.end <- grepl("END OF DATA", headers)
   my.end <- which(my.end)
   
   # if end of data is not found, use length of the whole file,
   # otherwise, omit the one row with the end of data indicator
   if (length(my.end) == 0) {
      my.end <- length(headers)
   } else {
      my.end <- my.end - start.of.data - 1
   }
   
   # now actually import the data
   the.data <- utils::read.csv(file, 
                               header = F, 
                               skip = start.of.data, 
                               nrows = my.end)
   names(the.data) <- the.names
      
   # convert time and date to POSIX
   my.time <- paste(the.data$Date, the.data$Time, sep = " ")
   the.data$Datetime <- as.POSIXct(my.time, format = "%d/%m/%Y %H:%M:%S")

   #update parameter names and units to reflect the new parameter "Datetime"
   the.names <- c("Datetime", the.names)
   the.units <- c("Datetime", the.units)
   
   # reorder columns
   df.names <- names(the.data)

   the.data <- the.data[, c("Datetime", df.names)]
   
   # in case there are duplicates, the additional Datetime parameter gets deleted.
   the.data$Datetime.1 <- NULL
   
   # assemble output
   # list of data, Names, units
   my.list <- list(the.data, the.names, the.units)
   names(my.list) <- c("Data", "Parameters", "Units")
   return(my.list)
}
