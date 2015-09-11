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





## Plot4.R
##
png("Plot4.png")
par(mfrow=c(2,2))

## TOP LEFT
plot(electricityData$Date, electricityData$Global_active_power,
     type = "l",
     main = " ",
     xlab = " ",
     ylab = "Global Active Power",
     col  = "black")


## TOP RIGHT
plot(electricityData$Date, electricityData$Voltage,
     type = "l",
     main = " ",
     xlab = "datatime",
     ylab = "Voltage",
     col  = "black")


## BOTTOM LEFT
plot(electricityData$Date, electricityData$Sub_metering_1,
     main = " ",
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


## BOTTOM RIGHT
plot(electricityData$Date, electricityData$Global_reactive_power,
     main = " ",
     xlab = "datatime",
     ylab = "Global_reactive_power",
     col  = "black",
     type = "l")


dev.off()

