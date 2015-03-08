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
png(file="plot4.png")
par(mfrow=c(2,2))
plot(vals$Time, vals$GAP, ylab = "Global Active Power", type = "n", main = "", 
     xlab = "")
lines(vals$Time, vals$GAP, col = "black")
plot(vals$Time, vals$Voltage, xlab = "datetime", ylab = "Voltage", type = "n", 
     main = "")
lines(vals$Time, vals$Voltage, col = "black")
plot(vals$Time, vals$Sub1, ylab = "Energy sub metering", type = "n", main = "", 
     xlab = "")
lines(vals$Time, vals$Sub1, col = "black")
lines(vals$Time, vals$Sub2, col = "red")
lines(vals$Time, vals$Sub3, col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(vals$Time, vals$GRP, xlab = "datetime", ylab = "Global_rective_power", 
     type = "n", main = "")
lines(vals$Time, vals$GRP, col = "black")
dev.off()