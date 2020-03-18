########################################################################
# FILENAME: plot1.R
# AUTHOR: Anne Strader
# LAST REVISED: 18. March 2020
#
# OBJECTIVE: 
# Replicate plot 1 for:
# Coursera Exploratory Data Analysis course
# Week 1 Course Project
#
# OUTPUT:
# plot1.png
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
# create plot 1
#########################################################################

# open png graphics device
png("plot1.png", width=480, height=480)

# convert values in Global_active_power to numeric type
Global_active_power <- as.numeric(subsetPowerData$Global_active_power)

# create histogram
hist(Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# close graphics device
dev.off()

