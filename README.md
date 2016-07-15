# Environdataimport

[![Build Status](https://travis-ci.org/MarkusLoew/Environdataimport.svg?branch=master)](https://travis-ci.org/MarkusLoew/Environdataimport)

R package to import files created by an Environdata weather station http://environdata.com.au/

See 

	help(package = "Environdataimport"") 

for details on the function provided by this package.
The import functions returns a list with three items: data, parameters, units.


### Installation

Installation straight from github (if package "devtools" is already installed) via

```{r}
install_github("MarkusLoew/Environdataimport")
```

### Example session
```{r}
# load Environdataimport package from the library
library(Environdataimport)

# the file to import
daily  <- "Daily Summary Jan-Jun 2016.csv"

# importing the file
weather <- EnvironImport(daily)

class(weather)
[1] "list"

length(weather)
[1] 3

names(weather)
[1] "Data"       "Parameters" "Units" 

head(weather$Data)

weather$Parameters

weather$Units
```
