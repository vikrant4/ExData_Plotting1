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
                                sep=";", header=T, skip = z[1]-1,
                                nrows = length(z), na.strings="?",
                                colClasses = c(rep("character", 2), "numeric",
                                               rep("NULL", 6)))

colnames(power_consumption) <- c("Date", "Time", 
                                 "Global_active_power")

png("plot1.png", width=480, height = 480)
hist(power_consumption[,3], col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()