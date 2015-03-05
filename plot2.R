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
png(filename = "plot2.png", bg = "transparent") # Opening png graphic device.
plot(data_formatted$DateTime,
     data_formatted$Global_active_power,
     type = "l",
     xlab = "",
     ylab= "Global Active Power (kilowatts)")
dev.off() # Closing png graphic device.