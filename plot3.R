
# Use sqldf to load only the data required. Install the package if it's not already there.
if(!require('sqldf')){
    install.packages('sqldf')
}

library(sqldf)

targetFile <- 'household_power_consumption.txt'

# Vector specifying the column data types.
cols <- c("character", "character", rep("numeric", 7))

# sql query to fetch only the required columns.
sql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"

# Read in the required rows.
d <- read.csv.sql(targetFile, sql, sep=';'
                  ,colClasses=cols
                  ,header=T)

# Get the datetime in order to plot against it by creating a vector of strings with the date and time,
# then converting them to datetimes.
dateTime <- paste(d$Date, d$Time, sep=' ')
dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")

# We add the datetime vector as a new column to the imported data.
d$DateTime <- dateTime

# plot to png
png('plot3.png', width=480, height=480, bg='transparent')
with(d, {plot(DateTime, Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, type='l', col='red')
    lines(DateTime, Sub_metering_3, type='l', col='blue')
})

legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd='1', col=c('black', 'red', 'blue'))
dev.off()

# plot to screen
dev.set(1)
with(d, {
    plot(DateTime, Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, type='l', col='red')
    lines(DateTime, Sub_metering_3, type='l', col='blue')
})

legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd='1', col=c('black', 'red', 'blue'))
