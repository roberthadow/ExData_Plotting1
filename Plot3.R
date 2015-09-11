## exdata
##
## Common preprocess pattern.  Time data rolled into Date column.
##
## All plots using plot().
##
##
## PREPROCESS
if(!file.exists("data")) dir.create("data")
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
myFile = "./data/household_power_consumption.txt"
download.file(fileUrl, myFile)
dateDownloaded = date()
electricityData = read.table(myFile, sep  = ";", header = TRUE,
        na.strings = "?", stringsAsFactors = FALSE)
electricityData$Date <- as.Date(electricityData$Date, format = "%d/%m/%Y")
electricityData <- subset(electricityData, Date >= "2007-02-01" & Date <= "2007-02-02")
electricityData$Date <- as.POSIXct(paste(electricityData$Date, " ",
                                         electricityData$Time),
                                         format = "%Y-%m-%d %H:%M:%S")



## Plot3.R
##
png("Plot3.png")
plot(electricityData$Date, electricityData$Sub_metering_1,
        col = "black",
        type = "s",
        xlab = " ",
        ylab = "Energy sub metering")


points(electricityData$Date, electricityData$Sub_metering_2, type = "s", col = "red")
points(electricityData$Date, electricityData$Sub_metering_3, type = "s", col = "blue")

legend("topright", legend = c("Sub metering 1",
                              "Sub metering 2",
                              "Sub metering 3"),
       col = c("black", "red", "blue"),
       lty = 1,
       pch = c(15, 15, 15, 15))

dev.off()



