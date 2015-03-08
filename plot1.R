## The script loads household_power_consumption.txt, 
## selects Global Active Power values from the dates 2007-02-01 and 2007-02-02, 
## and plots a histogram of the values.

library("data.table")
data <- fread("household_power_consumption.txt", header = T, stringsAsFactors = F, 
              colClasses = list(character=1:9), sep = ";", na.strings = "?")
apow <- data[Date %in% c("1/2/2007", "2/2/2007"), as.numeric(Global_active_power)]
png(file="plot1.png")
hist(apow, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", 
     col="red")
dev.off()
