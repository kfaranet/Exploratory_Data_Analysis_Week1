# Course 4 Week 1 Peer Graded Project
# Plot 4

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


# Build and save Plot4.png
png("plot4.png", width = 480, height = 480)
attach(feb_data2)
par(mfrow=c(2,2))
# TopLeft
plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power", xlab="")
# TopRight
plot(feb_data2$date_time, feb_data2$Voltage, type = "l", ylab = "Voltage", xlab="datetime")
# BottomLeft
plot(feb_data2$date_time, feb_data2$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(feb_data2$date_time, feb_data2$Sub_metering_2, type = "l", col = "red")
lines(feb_data2$date_time, feb_data2$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty = 1, bty="n")
# BottomRight
plot(feb_data2$date_time, feb_data2$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime")
dev.off()