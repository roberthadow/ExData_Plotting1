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

