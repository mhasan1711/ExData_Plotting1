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
#Extract Parameters for line chart
Sub_metering_1 <- as.numeric(myFilteredData$Sub_metering_1)
Sub_metering_2 <- as.numeric(myFilteredData$Sub_metering_2)
Sub_metering_3 <- as.numeric(myFilteredData$Sub_metering_3)
Date_Time <- strptime(paste(myFilteredData$Date, myFilteredData$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
#initiate device
png('plot3.png', width = 480, height = 480)
#create the chart
plot(Date_Time, Sub_metering_1, type = "n", xlab = "",  ylab = "Energy sub metering")
points(Date_Time, Sub_metering_1, type = "l")
points(Date_Time, Sub_metering_2, type = "l", col = "red")
points(Date_Time, Sub_metering_3, type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                  col = c("black","red","blue"), 
                  lty = 1
       )
#swich off the device and give control back to the screen
dev.off()