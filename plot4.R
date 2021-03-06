#Set working directory
myDirectory = "/Users/kevin/Dropbox/Coursera/4 - Exploratory Data Analysis/Course Project 1/ExData_Plotting1/"
setwd(myDirectory)

#Get dataset
datasetUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datasetZip = "household_power_consumption.zip"
download.file(url = datasetUrl, destfile = datasetZip, method="curl")
unzip(zipfile=datasetZip)

#Read dataset
household_power_consumption_table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

#Massage dataset
cols <- c( 'Date' , 'Time')
household_power_consumption_table$date_and_time_as_characters <- apply (household_power_consumption_table[,cols],1,paste,collapse=" ")
household_power_consumption_table$date_and_time_as_date <- as.POSIXlt.character(x=household_power_consumption_table$date_and_time_as_characters, format="%d/%m/%Y %H:%M:%S")

# Plot 4
png("plot4.png", width=480, height=480, units = "px")
plot_data = subset(household_power_consumption_table, household_power_consumption_table$date_and_time_as_date > as.POSIXlt("2007-02-01") & household_power_consumption_table$date_and_time_as_date < as.POSIXlt("2007-02-03"))
par(mfrow = c(2, 2))

# Plot 4:1,1
xrange = range(plot_data$date_and_time_as_date)
yrange = range(plot_data$Global_active_power)
plot(xrange, yrange, type = "n", xlab="", ylab="Global Active Power")
lines(x = plot_data$date_and_time_as_date, y=plot_data$Global_active_power, type="l", col="black")

# Plot 4:2,1
xrange = range(plot_data$date_and_time_as_date)
yrange = range(plot_data$Voltage)
plot(xrange, yrange, type = "n", xlab="datetime", ylab="Voltage")
lines(x = plot_data$date_and_time_as_date, y=plot_data$Voltage, type="l", col="black")

# Plot 4:1,2
xrange = range(plot_data$date_and_time_as_date)
yrange = range(plot_data$Sub_metering_1, plot_data$Sub_metering_2, plot_data$Sub_metering_3)
plot(xrange, yrange, type="n", xlab="", ylab="Energy sub metering" ) 
lines(x = plot_data$date_and_time_as_date, y=plot_data$Sub_metering_1, type = "l", col="black")
lines(x = plot_data$date_and_time_as_date, y=plot_data$Sub_metering_2, type = "l", col="red")
lines(x = plot_data$date_and_time_as_date, y=plot_data$Sub_metering_3, type = "l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n", cex = 0.9)

# Plot 4:2,2
xrange = range(plot_data$date_and_time_as_date)
yrange = range(plot_data$Global_reactive_power)
plot(xrange, yrange, type = "n", xlab="datetime", ylab="Global_reactive_power")
lines(x = plot_data$date_and_time_as_date, y=plot_data$Global_reactive_power, type="l", col="black")

dev.off()
