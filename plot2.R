
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
png('plot2.png', width=480, height=480, bg='transparent')
with(d, {
    plot(DateTime, Global_active_power, type='l', xlab='', ylab="Global active power")
})
dev.off()

