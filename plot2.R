# set working directory (change this to fit your needs)
setwd("E:/coursera/Exploratory Data Analysis_1")

# make sure the plots folder exists
if (!file.exists('plots')) {
  dir.create('plots')
}

# load data
source("E:/coursera/Exploratory Data Analysis_1/load_data.R")

# open device
png(filename='plots/plot2.png',width=480,height=480,units='px')

# plot data
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

# close device
x<-dev.off()