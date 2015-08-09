## Setting the boundary values for Date variable
startDate <- "2007-02-01"
endDate <- "2007-02-02"

## Only the first column is taken to get the right dates
power_consumption_date <- read.table("household_power_consumption.txt", sep = ";",
                                     na.strings = "?", header = T,
                                     colClasses = c("character", rep("NULL", 8)))

## Converted to date data type using POSIXct
power_consumption_date[,1] <- as.POSIXct(power_consumption_date[,1],
                                         format="%d/%m/%Y")

## Getting the right rows
correct_date_rows <- which(power_consumption_date[,1] == startDate | power_consumption_date[,1] == endDate)

rm(power_consumption_date, startDate, endDate)

## Only the Date, Time and the Sub_metering values are read for required rows
power_consumption <- read.table("household_power_consumption.txt",
                                sep=";", header=T, 
                                skip = correct_date_rows[1]-1,
                                nrows = length(correct_date_rows), 
                                na.strings="?",
                                colClasses = c(rep("character", 2),
                                               rep("numeric", 7)))

## Date and Time variable are combined for a continuous datetime vector
datetime <- as.POSIXct(paste(power_consumption[,1], power_consumption[,2]),
                       format = "%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height = 480)
## Setting the pane for 2x2 plots
par(mfrow = c(2,2))
## First plot
plot(power_consumption[,3]~datetime, type="l",
     ylab = "Global Active Power (killowatts)", 
     xlab='', main=NULL)
## Second plot
plot(power_consumption[,5]~datetime, type="l",
     ylab="Voltage", xlab="datetime", main=NULL)
##Third plot
plot(power_consumption[,7]~datetime, type="l",
     xlab='', ylab = "Energy sub metering")
## Additional points for the third plot
points(power_consumption[,8]~datetime, col = "red", type="l")
## Additional points for the third plot
points(power_consumption[,9]~datetime, col = "blue", type = "l")
## Legendsfor the third plot
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Fourth plot
plot(power_consumption[,4]~datetime, type="l")
dev.off()