#read zip file to obtain full data.
data <- read.table(unz("exdata-data-household_power_consumption.zip", 
                   "household_power_consumption.txt"), header = TRUE, 
                   sep = ";", dec = ".")

sub.data <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]

#plotting the histogram of global.active.power
global.active.power <- as.numeric(as.character(sub.data$Global_active_power))

hist(global.active.power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="Red")

png("plot1.png", width=480, height=480)
dev.off()
