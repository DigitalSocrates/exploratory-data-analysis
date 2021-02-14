# load libraries 
library(downloader)

# download and unzip data
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(url, dest="F:\\r_stuff\\dataset.zip", mode="wb") 
unzip (zipfile = "F:\\r_stuff\\dataset.zip",exdir = "F:\\r_stuff");

# read data in and set global variables
data <- read.table(text = grep("^[1,2]/2/2007", readLines("F:\\r_stuff\\household_power_consumption.txt"), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

# Converting date and time
data$Date <- as.Date(data$Date, format = "%d/%m/%Y") 
DateTime <- paste(as.Date(data$Date), data$Time) 
data$DateTime <- as.POSIXct(DateTime)

# set global params for image widdth and height, and units
width = 480
height = 480
units = "px"

# folder 
folder = "F:\\r_stuff\\"


# Plot 3
# name:
# use: histogram
# column: Global_active_power
# include units in title
# write the output in png format

# build a full path
filePath = file.path(folder,"plot3.png", fsep = .Platform$file.sep)

# Open PNG device
png(file = filePath, width = width, height = height, units = units)

# Generating Plot
with(data, {
  plot(Sub_metering_1 ~ DateTime, col="black", type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ DateTime, col = 'red')
  lines(Sub_metering_3 ~ DateTime, col = 'blue')
})

# Add legend
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close device
dev.off()
