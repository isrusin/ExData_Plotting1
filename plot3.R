## The script loads household_power_consumption.txt,
## selects Sub_metering values from the dates 2007-02-01 and 2007-02-02,
## and plots these values vs. time.

library("data.table")
data <- fread("household_power_consumption.txt", header = T, stringsAsFactors = F,
              colClasses = list(character = 1:9), sep = ";", na.strings = "?")
vals <- data[Date %in% c("1/2/2007", "2/2/2007"),
             list("Time" = strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
                  "Sub1" = as.numeric(Sub_metering_1),
                  "Sub2" = as.numeric(Sub_metering_2),
                  "Sub3" = as.numeric(Sub_metering_3))]
Sys.setlocale("LC_TIME", "en_US.UTF-8")
png(file = "plot3.png", bg = "transparent")
with(vals, {
	plot(Time, Sub1, xlab = "", ylab = "Energy sub metering", type = "n")
	lines(Time, Sub1, col = "black")
	lines(Time, Sub2, col = "red")
	lines(Time, Sub3, col = "blue")
	legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"),
	       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
