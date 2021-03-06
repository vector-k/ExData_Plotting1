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

#Plot 1
png("plot1.png", width=480, height=480, units = "px")
plot_data <- subset(household_power_consumption_table, household_power_consumption_table$date_and_time_as_date > as.POSIXlt("2007-02-01") & household_power_consumption_table$date_and_time_as_date < as.POSIXlt("2007-02-03"))
hist(plot_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
