## The script loads household_power_consumption.txt, 
## selects Global Active Power values from the dates 2007-02-01 and 2007-02-02, 
## and plots these values vs. time.

library("data.table")
data <- fread("household_power_consumption.txt", header = T, stringsAsFactors = F, 
              colClasses = list(character = 1:9), sep = ";", na.strings = "?")
vals <- data[Date %in% c("1/2/2007", "2/2/2007"), 
             list("Time" = strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"), 
                  "GAP" = as.numeric(Global_active_power))]
Sys.setlocale("LC_TIME", "en_US.UTF-8")
png(file="plot2.png")
plot(vals$Time, vals$GAP, ylab = "Global Active Power (kilowatts)", type = "n", 
     main = "", xlab = "")
lines(vals$Time, vals$GAP)
dev.off()
