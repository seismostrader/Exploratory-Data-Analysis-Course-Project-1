########################################################################
# FILENAME: plot2.R
# AUTHOR: Anne Strader
# LAST REVISED: 18. March 2020
#
# OBJECTIVE: 
# Replicate plot 2 for:
# Coursera Exploratory Data Analysis course
# Week 1 Course Project
#
# OUTPUT:
# plot2.png
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
# create plot 2
#########################################################################

# create a column in data subset containing date/time in POSIXlt format
subsetPowerData$dateTime <- strptime(paste(subsetPowerData$Date, 
                                     subsetPowerData$Time), 
                                    "%d/%m/%Y %H:%M:%S")

# convert values in Global_active_power to numeric type
Global_active_power <- as.numeric(subsetPowerData$Global_active_power)

# open png graphics device
png("plot2.png", width=480, height=480)

# plot Global_active_power over time
plot(subsetPowerData$dateTime, Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

# close graphics device
dev.off()
