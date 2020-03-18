########################################################################
# FILENAME: plot3.R
# AUTHOR: Anne Strader
# LAST REVISED: 18. March 2020
#
# OBJECTIVE: 
# Replicate plot 3 for:
# Coursera Exploratory Data Analysis course
# Week 1 Course Project
#
# OUTPUT:
# plot3.png
#########################################################################

#########################################################################
# download and extract dataset
#########################################################################

# define URL where source data are stored
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# define source data zip file name
sourceDataZipFile <- "household_power_consumption.zip"

# check if dataset has already been downloaded in working directory, and download dataset if not
if (!file.exists(sourceDataZipFile)) {
  download.file(sourceURL, sourceDataZipFile)
}

# define source data directory name
sourceDataPath <- "household_power_consumption" 

# if not already done, unzip source dataset to new data directory
if (!file.exists(sourceDataPath)) {
  unzip(sourceDataZipFile)
}

#########################################################################
# read the dataset, subset useful time window
#########################################################################

# read in data as a data table
powerData <- read.table("household_power_consumption.txt", 
                        header=TRUE, sep=";", stringsAsFactors=FALSE, 
                        na.strings="?")

# subset data from 01/02/2007 and 02/02/2007
subsetPowerData <- subset(powerData[powerData$Date %in% 
                          c("1/2/2007","2/2/2007") ,])

#########################################################################
# create plot 3
#########################################################################

# convert Sub_metering_1, Sub_metering_2 and Sub_metering_3 to numeric
# type
subsetPowerData$Sub_metering_1 <- as.numeric(subsetPowerData$Sub_metering_1)
subsetPowerData$Sub_metering_2 <- as.numeric(subsetPowerData$Sub_metering_2)
subsetPowerData$Sub_metering_3 <- as.numeric(subsetPowerData$Sub_metering_3)

# create a column in data subset containing date/time in POSIXlt format
subsetPowerData$dateTime <- strptime(paste(subsetPowerData$Date, 
                                           subsetPowerData$Time), 
                                     "%d/%m/%Y %H:%M:%S")

# open png graphics device
png("plot3.png", width=480, height=480)

# plot Sub_metering_1 over time
plot(subsetPowerData$dateTime, subsetPowerData$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")

# plot Sub_metering_2 over time (add to same plot)
lines(subsetPowerData$dateTime, subsetPowerData$Sub_metering_2, type="l", 
      col="red")

# plot Sub_metering_3 over time (add to same plot)
lines(subsetPowerData$dateTime, subsetPowerData$Sub_metering_3, type="l",
      col="blue")

# add legend to plot
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=1, col=c("black", "red", "blue"))

# close graphics device
dev.off()
