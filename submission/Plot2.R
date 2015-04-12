data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
a1 <- "2007-02-01 00:00:00"
a2 <- "2007-02-03 00:00:00"
b1 <- as.POSIXct(a1)
b2 <- as.POSIXct(a2)
X <- data[(data$DateTime < b2 & data$DateTime >= b1), ]
X <- transform(X, Global_active_power = as.numeric(Global_active_power))
png('Plot2.png', width = 480, height = 480)
plot(X$DateTime, X$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.off()