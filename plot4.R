# Reading data.
data <- read.table(file = "household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   na.strings = "?",
                   stringsAsFactors = FALSE)

# Formatting data.
data_formatted <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
temp1 <- as.Date(data_formatted$Date, format = "%d/%m/%Y")
data_formatted$day <- weekdays(temp1)
temp2 <- paste(data_formatted$Date, data_formatted$Time)
data_formatted$DateTime <- strptime(temp2, format = "%d/%m/%Y %H:%M:%S")

# Plotting data.
png(filename = "plot4.png", bg = "transparent") # Opening png graphic device.
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(data_formatted, {
    # Top left plot:
    plot(DateTime, Global_active_power, type = "l",
         ylab = "Global Active Power", xlab = "")
    # Top right plot:
    plot(DateTime, Voltage, type = "l", , xlab = "datetime")
    # Bottom left plot:
    plot(DateTime,
         data_formatted$Sub_metering_1,
         type = "l",
         xlab = "",
         ylab= "Energy sub metering",
         col = "black")
    lines(DateTime,
          data_formatted$Sub_metering_2,
          col = "red")
    lines(DateTime,
          data_formatted$Sub_metering_3,
          col = "blue")
    legend("topright",
           lty=1,
           col = c("black","red","blue"),
           legend = c("Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3"))
    # Bottom right plot:
    plot(DateTime, Global_reactive_power, type = "l",
         yaxp = c(0.0, 0.5, 5), xlab = "datetime")
    })
dev.off() # Closing png graphic device.