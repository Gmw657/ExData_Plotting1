#setting up the defaults
knitr::opts_chunk$set(echo = TRUE, results = "asis")

# make sure the sources data folder exists
if (!file.exists('source data')) {
  dir.create('source data')
}

# check to see if the existing tidy data set exists; if not, make it...
if (!file.exists('source data/power_consumption.txt')) {
  
  # download the zip file and unzip
  file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(file.url,destfile='source data/power_consumption.zip')
  unzip('source data/power_consumption.zip',exdir='source data',overwrite=TRUE)
  
  t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
  
  ## Format date to Type Date
  t$Date <- as.Date(t$Date, "%d/%m/%Y")
  
  ## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
  t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
  ## Remove incomplete observation
  t <- t[complete.cases(t),]
  
  ## Combine Date and Time column
  dateTime <- paste(t$Date, t$Time)
  
  ## Name the vector
  dateTime <- setNames(dateTime, "DateTime")
  
  ## Remove Date and Time column
  t <- t[ ,!(names(t) %in% c("Date","Time"))]
  
  ## Add DateTime column
  t <- cbind(dateTime, t)
  
  ## Format dateTime Column
  t$dateTime <- as.POSIXct(dateTime)
