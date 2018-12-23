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
Global_active_power <- as.numeric(myFilteredData$Global_active_power)

png('plot1.png', width = 480, height = 480)

hist(Global_active_power, main = "Global Active Power", 
                          xlab = "Global Active Power (kilowatts)", 
                          col = "red"
     )

dev.off()