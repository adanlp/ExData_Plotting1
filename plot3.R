# plot3.R
#
# Construct the corresponding plot for Plotting Assignment 1 
# for Exploratory Data Analysis. In this case, plot3.png
# 

# Define the source of data and a name for our file
my_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
my_file <- "household_power_consumption.zip"

# If not exist, download and unzip the file (avoid downloading every time)
if (!file.exists(my_file)){
    download.file(my_url, my_file)
    unzip(my_file)
}

# Load the data only for the desired dates (2007-02-01 and 2007-02-02)
my_data <- read.table("household_power_consumption.txt", sep=";", 
			skip=66637, nrows=2879)

# Set column names and convert Date column to date type
my_cols <- c("Date","Time","Global_active_power","Global_reactive_power",
			"Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
			"Sub_metering_3")
colnames(my_data) <- my_cols
my_data <- transform(my_data, Date=as.Date(Date, "%d/%m/%Y"))
my_data$Time <- paste(my_data$Date, my_data$Time)
my_data <- transform(my_data, Time=strptime(Time, "%Y-%m-%d %H:%M:%S"))

# Generates the plot with following options:
#   y label=Energy sub metering
#   y data=Sub_metering 1(black), 2(red), and 3 (blue)
#   legend top right
# 	output file=plot3.png
plot(x=(my_data$Time), y=my_data$Sub_metering_1, type="l",
            ylab="Energy sub metering", xlab="")
lines(x=(my_data$Time), y=my_data$Sub_metering_2, col="red")
lines(x=(my_data$Time), y=my_data$Sub_metering_3, col="blue")
legend("topright", pch=151, col=c("black","red","blue"), 
            legend=c("Sub_metering_1","Sub_metering_2",
            "Sub_metering_3"))
dev.copy(png, file="plot3.png")
dev.off()
