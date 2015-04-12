data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
a1 <- "2007-02-01 00:00:00"
a2 <- "2007-02-03 00:00:00"
b1 <- as.POSIXct(a1)
b2 <- as.POSIXct(a2)
X <- data[(data$DateTime < b2 & data$DateTime >= b1), ]
X <- transform(X, Global_active_power = as.numeric(Global_active_power),
               Global_reactive_power = as.numeric(Global_reactive_power))
               Voltage = as.numeric(Voltage), 
               Sub_metering_1 = as.numeric(Sub_metering_1), 
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3))
png('Plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
with (X, {
        plot(DateTime, Global_active_power, type = "l", xlab = "", ylab="Global Active Power")
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab="Voltage")
        plot(X$DateTime, X$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering")
         with(X, lines(DateTime, Sub_metering_2, col = "red"))
         with(X, lines(DateTime, Sub_metering_3, col = "blue"))
         legend("topright", pch=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab="Global Reactive Power")
})
dev.off()