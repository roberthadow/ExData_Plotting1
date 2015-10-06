## exdata Plot3/R
##
## Common preprocess pattern.  Time data rolled into Date column.
##
## All plots using plot().
##
##
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



## Plot3.R
##
png("Plot3.png")
plot(electricityData$Date, electricityData$Sub_metering_1,
        col = "black",
        type = "l",
        xlab = " ",
        ylab = "Energy sub metering")


points(electricityData$Date, electricityData$Sub_metering_2, type = "l", col = "red")
points(electricityData$Date, electricityData$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = c("Sub metering 1",
                              "Sub metering 2",
                              "Sub metering 3"),
       col = c("black", "red", "blue"),
       lty = 1,
       pch = c(15, 15, 15, 15))

dev.off()



