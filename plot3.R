startDate <- "2007-02-01"
endDate <- "2007-02-02"

## Only the first column is taken to get the right dates
power_consumption_date <- read.table("household_power_consumption.txt", sep = ";",
                                     na.strings = "?", header = T,
                                     colClasses = c("character", rep("NULL", 8)))

power_consumption_date[,1] <- as.POSIXct(power_consumption_date[,1],
                                         format="%d/%m/%Y")
correct_date_rows <- which(power_consumption_date[,1] == startDate | power_consumption_date[,1] == endDate)

rm(power_consumption_date, startDate, endDate)

power_consumption <- read.table("household_power_consumption.txt",
                                sep=";", header=T, 
                                skip = correct_date_rows[1]-1,
                                nrows = length(correct_date_rows), 
                                na.strings="?",
                                colClasses = c(rep("character", 2),
                                               rep("NULL", 4),
                                               rep("numeric", 3)))
datetime <- as.POSIXct(paste(power_consumption[,1], power_consumption[,2]),
                       format = "%d/%m/%Y %H:%M:%S")
png("plot3.png", width=480, height = 480)
plot(power_consumption[,3]~datetime, type="l",
     xlab='', ylab = "Energy sub metering")
points(power_consumption[,4]~datetime, col = "red", type="l")
points(power_consumption[,5]~datetime, col = "blue", type = "l")
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()