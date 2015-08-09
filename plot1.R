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

## Only the Date and Global Active Power variable are read for required rows
power_consumption <- read.table("household_power_consumption.txt",
                                sep=";", header=T, 
                                skip = correct_date_rows[1]-1,
                                nrows = length(correct_date_rows), 
                                na.strings="?",
                                colClasses = c("character", "NULL", "numeric",
                                               rep("NULL", 6)))

colnames(power_consumption) <- c("Date", "Global_active_power")

png("plot1.png", width=480, height = 480)
hist(power_consumption[,2], col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()