## The script loads household_power_consumption.txt,
## selects values from the dates 2007-02-01 and 2007-02-02,
## and plots Global Active Power, Global Reactive Power,
## Voltage and Sub Meterings vs. time.

library("data.table")
data <- fread("household_power_consumption.txt", header = T, stringsAsFactors = F,
              colClasses = list(character = 1:9), sep = ";", na.strings = "?")
vals <- data[Date %in% c("1/2/2007", "2/2/2007"),
             list("Time" = strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
                  "GAP" = as.numeric(Global_active_power),
                  "GRP" = as.numeric(Global_reactive_power),
                  "Voltage" = as.numeric(Voltage),
                  "Sub1" = as.numeric(Sub_metering_1),
                  "Sub2" = as.numeric(Sub_metering_2),
                  "Sub3" = as.numeric(Sub_metering_3))]
Sys.setlocale("LC_TIME", "en_US.UTF-8")
png(file = "plot4.png", bg = "transparent")
par(mfrow=c(2,2))
with(vals, {
	# top left plot
	plot(Time, GAP, xlab = "", ylab = "Global Active Power", type = "n")
	lines(Time, GAP, col = "black")
	# top right plot
	plot(Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
	lines(Time, Voltage, col = "black")
	# bottom left plot
	plot(Time, Sub1, xlab = "", ylab = "Energy sub metering", type = "n")
	lines(Time, Sub1, col = "black")
	lines(Time, Sub2, col = "red")
	lines(Time, Sub3, col = "blue")
	legend("topright", lty = c(1, 1, 1), bty = "n", col = c("black", "red", "blue"),
	       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	# bottom right plot
	plot(Time, GRP, xlab = "datetime", ylab = "Global_rective_power", type = "n")
	lines(Time, GRP, col = "black")
})
dev.off()
