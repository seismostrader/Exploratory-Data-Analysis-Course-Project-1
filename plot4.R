########################################################################
# FILENAME: plot4.R
# AUTHOR: Anne Strader
# LAST REVISED: 18. March 2020
#
# OBJECTIVE: 
# Replicate plot 4 for:
# Coursera Exploratory Data Analysis course
# Week 1 Course Project
#
# OUTPUT:
# plot4.png
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
# create plot 4
#########################################################################

# convert Sub_metering_1, Sub_metering_2 and Sub_metering_3 to numeric
# type
subsetPowerData$Sub_metering_1 <- as.numeric(subsetPowerData$Sub_metering_1)
subsetPowerData$Sub_metering_2 <- as.numeric(subsetPowerData$Sub_metering_2)
subsetPowerData$Sub_metering_3 <- as.numeric(subsetPowerData$Sub_metering_3)

# convert Global_active_power, Global_reactive_power and Voltage to 
# numeric type
subsetPowerData$Global_active_power <- as.numeric(subsetPowerData$Global_active_power)
subsetPowerData$Global_reactive_power <- as.numeric(subsetPowerData$Global_reactive_power)
subsetPowerData$Voltage <- as.numeric(subsetPowerData$Voltage)

# create a column in data subset containing date/time in POSIXlt format
subsetPowerData$dateTime <- strptime(paste(subsetPowerData$Date, 
                                           subsetPowerData$Time), 
                                     "%d/%m/%Y %H:%M:%S")

# open png graphics device
png("plot4.png", width=480, height=480)

# set number of subplots (rows, columns) and the order to be generated
par(mfrow = c(2, 2))

# plot Global_active_power over time
plot(subsetPowerData$dateTime, subsetPowerData$Global_active_power,
     type="l", xlab="", ylab="Global Active Power")

# plot Voltage over time
plot(subsetPowerData$dateTime, subsetPowerData$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# plot Sub_metering_1, Sub_metering_2 and Sub_metering_3 over time

# Sub_metering_1
plot(subsetPowerData$dateTime, subsetPowerData$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")

# Sub_metering_2
lines(subsetPowerData$dateTime, subsetPowerData$Sub_metering_2, type="l", 
      col="red")

# Sub_metering_3
lines(subsetPowerData$dateTime, subsetPowerData$Sub_metering_3, type="l",
      col="blue")

# add legend to plot
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=1, col=c("black", "red", "blue"), bty="n")

# plot Global_reactive_power over time
plot(subsetPowerData$dateTime, subsetPowerData$Global_reactive_power,
     type="l", xlab="datetime", ylab="Global_reactive_power")

# close graphics device
dev.off()
