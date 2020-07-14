# Course 4 Week 1 Peer Graded Project
# Plot 1

# Load Packages
library(dplyr)


# Download file from website and unzip in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "power_consumption.zip")
unzip("power_consumption.zip")

# Read data into R, convert Date to a date class and filter on 2/1/2007 and 2/2/2007
power_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")
feb_data <- power_consumption[power_consumption$Date == as.Date("02/01/2007", "%m/%d/%Y") | power_consumption$Date == as.Date("02/02/2007", "%m/%d/%Y"),]
feb_data2 <- mutate(feb_data, date_time = paste(feb_data$Date, feb_data$Time))
feb_data2$date_time <- strptime(feb_data2$date_time, "%Y-%m-%d %H:%M:%S")


# Build and save Plot2.png
png("plot1.png", width = 480, height = 480)
hist(feb_data2$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

