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
             Datetime       Date     Time Maximum Wind Speed  Average Wind Speed  Standard Deviation Wind Speed  Average Wind Direction  Yamartino Calculation Wind Direction  Maximum Peak Wind Gust 
1 2016-01-01 09:00:00 01/01/2016 09:00:00               26.75                7.45                           4.59                  219.96                                 85.40                      48
2 2016-01-02 09:00:00 02/01/2016 09:00:00               27.25               13.46                           3.60                  195.12                                 18.63                      36
3 2016-01-03 09:00:00 03/01/2016 09:00:00               25.00               10.50                           5.49                  160.47                                 22.44                      33
4 2016-01-04 09:00:00 04/01/2016 09:00:00               29.50                8.86                           5.48                  137.12                                 54.78                      35
5 2016-01-05 09:00:00 05/01/2016 09:00:00               24.65                5.66                           4.37                  131.68                                 57.20                      32
6 2016-01-06 09:00:00 06/01/2016 09:00:00               19.85                7.45                           3.94                  193.02                                 42.19                      28

weather$Parameters
 [1] "Date"                                  "Time"                                 
 [3] "Maximum Wind Speed "                   "Average Wind Speed "                  
 [5] "Standard Deviation Wind Speed "        "Average Wind Direction "              
 [7] "Yamartino Calculation Wind Direction " "Maximum Peak Wind Gust "              
 [9] "Vector Inst. Wind Speed "              "Vector Inst. Wind Direction "         
[11] "Maximum Relative Humidity "            "Minimum Relative Humidity "           
[13] "Average Relative Humidity "            "Maximum Air Temperature "             
[15] "Minimum Air Temperature "              "Average Air Temperature "             
[17] "Maximum Rain Gauge "                   "Total Rain Gauge "                    
[19] "Maximum Solar Radiation "              "Minimum Solar Radiation "             
[21] "Average Solar Radiation "              "Maximum Soil Temperature "            
[23] "Minimum Soil Temperature "             "Average Soil Temperature "            
[25] "Total Evaporation "                    "Minimum Battery Voltage "             
[27] "Average Solar Voltage "                "Average Load Current "                
[29] "Average Charge Current "               "Total Communications "

weather$Units
 [1] "[kph]"       "[kph]"       "[kph]"       "[Degrees]"   "[Degrees]"   "[km/h]"     
 [7] "[kph]"       "[Degrees]"   "[%]"         "[%]"         "[%]"         "[Degrees C]"
[13] "[Degrees C]" "[Degrees C]" "[mm]"        "[mm]"        "[Watts/m2]"  "[Watts/m2]" 
[19] "[Watts/m2]"  "[Degrees C]" "[Degrees C]" "[Degrees C]" "[mm]"        "[V]"        
[25] "[V]"         "[mA]"        "[mA]"        "[Minutes]"
```
