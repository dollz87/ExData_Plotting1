data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
a1 <- "2007-02-01 00:00:00"
a2 <- "2007-02-03 00:00:00"
b1 <- as.POSIXct(a1)
b2 <- as.POSIXct(a2)
X <- data[(data$DateTime < b2 & data$DateTime >= b1), ]
X <- transform(X, Sub_metering_1 = as.numeric(Sub_metering_1), 
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3))
png('Plot3.png', width = 480, height = 480)
plot(X$DateTime, X$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering")
with(X, lines(DateTime, Sub_metering_2, col = "red"))
with(X, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", pch=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()