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
Global_Active_Power <- as.numeric(myFilteredData$Global_active_power)
Date_Time <- strptime(paste(myFilteredData$Date, myFilteredData$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
#initiate device
png('plot2.png', width = 480, height = 480)
#create the chart
plot(Date_Time,Global_Active_Power, type = "l", ylab = "Global Active Power (Kilowatts)", xlab = "" )
#swich off the device and give control back to the screen
dev.off()