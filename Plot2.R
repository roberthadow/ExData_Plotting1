## exdata Plot2.R
##
## Common preprocess pattern.  Time data rolled into Date column.
##
## All plots using plot().
####
## PREPROCESS
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
myFile = "./data/POWER.zip"
download.file(fileUrl, myFile, mode = "wb")
dateDownloaded = date()
unzip(myFile)
myFile = "household_power_consumption.txt"
electricityData = read.table(myFile, sep = ";", header = TRUE,
                             na.strings = "?", stringsAsFactors = FALSE, comment.char = "")
electricityData$Date <- as.Date(electricityData$Date, format = "%d/%m/%Y")
electricityData <- electricityData[electricityData$Date == "2007-02-01" |
                                           electricityData$Date == "2007-02-02", ]
electricityData$Date <- as.POSIXct(paste(electricityData$Date, " ",
                                         electricityData$Time),
                                   format = "%Y-%m-%d %H:%M:%S")


## Plot2.R
##

png("Plot2.png")
plot(electricityData$Date, electricityData$Global_active_power,
     type = "l",
     main = " ",
     xlab = " ",
     ylab = "Global Active Power (kilowatts)",
     col  = "red")
dev.off()

