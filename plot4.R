library(dplyr)
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset <- "exdata_data_household_power_consumption.zip"

if (!file.exists(dataset)) {
  download.file(dataUrl, dataset)
}

# unzip file containing data and create directory if data directory doesn't already exist
dataPath <- "exdata_data_household_power_consumption"
if (!file.exists(dataPath)) {
  unzip(dataset)
}
# read the file using read.table function, separated by ';'
myData <- read.table('household_power_consumption.txt', sep = ';', header = TRUE, stringsAsFactors = FALSE)
# convert date to proper format
myData$Date <- as.Date(myData$Date, "%d/%m/%Y")
# filter data for only Feb 1st and 2nd
myFilteredData <- filter(myData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
#Extract Parameters for charts
Sub_metering_1 <- as.numeric(myFilteredData$Sub_metering_1)
Sub_metering_2 <- as.numeric(myFilteredData$Sub_metering_2)
Sub_metering_3 <- as.numeric(myFilteredData$Sub_metering_3)
Voltage        <- as.numeric(myFilteredData$Voltage)
Global_Active_Power <- as.numeric(myFilteredData$Global_active_power)
Global_Reactive_Power <- as.numeric(myFilteredData$Global_reactive_power)
Date_Time <- strptime(paste(myFilteredData$Date, myFilteredData$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
#initiate device
png('plot4.png', width = 480, height = 480)
par(mfrow=c(2,2))
#create chart 1
plot(Date_Time, Global_Active_Power, xlab = "", ylab = "Global Active Power", type = "l")
#create chart 2
plot(Date_Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
#create chart 3
plot(Date_Time, Sub_metering_1, type = "n", xlab = "",  ylab = "Energy sub metering")
points(Date_Time, Sub_metering_1, type = "l")
points(Date_Time, Sub_metering_2, type = "l", col = "red")
points(Date_Time, Sub_metering_3, type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = 1
)
#create chart 4
plot(Date_Time, Global_Reactive_Power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
#swich off the device and give control back to the screen
dev.off()