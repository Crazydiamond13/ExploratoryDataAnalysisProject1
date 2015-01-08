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

#plotting the line graph of global.active.power
plot(global.active.power~sub.data$DateTime, type="l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

png("plot2.png", width=480, height=480)
dev.off()
