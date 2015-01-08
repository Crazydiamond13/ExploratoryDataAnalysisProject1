#read zip file to obtain full data.
data <- read.table(unz("exdata-data-household_power_consumption.zip", 
                       "household_power_consumption.txt"), header = TRUE, 
                   sep = ";", dec = ".")

#select only the time frame
sub.data <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]

#convert date and time to one vector
date.time <- paste(as.Date(sub.data$Date, format = "%d/%m/%Y"), sub.data$Time)
sub.data$DateTime <- as.POSIXct(date.time)

global.active.power <- as.numeric(as.character(sub.data$Global_active_power))
sub.metering.1 <- as.numeric(as.character(sub.data$Sub_metering_1))
sub.metering.2 <- as.numeric(as.character(sub.data$Sub_metering_2))
sub.metering.3 <- as.numeric(as.character(sub.data$Sub_metering_3))
voltage <- as.numeric(as.character(sub.data$Voltage))
global.reactive.power <- as.numeric(as.character(sub.data$Global_reactive_power))

#fills graph in columns
par(mfcol = c(2,2))

#first plot
plot(global.active.power~sub.data$DateTime, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

#second plot
plot(sub.metering.1~sub.data$DateTime, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(sub.metering.2~sub.data$DateTime, col = "red")
lines(sub.metering.3~sub.data$DateTime, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", cex = 0.3)

#third plot
plot(voltage~sub.data$DateTime, type = "l", xlab = "datetime",
     ylab = "Voltage")

#forth plot
plot(global.reactive.power~sub.data$DateTime, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

png("plot4.png", width = 480, height = 480)
dev.off()
