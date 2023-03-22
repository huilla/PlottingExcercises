######## POWER CONSUMPTION PLOTTING ########

# This R code file constructs the plot1.png plot

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset_file <- file.path(getwd(), "./originaldata.zip")
download.file(dataset_url, dataset_file)
unzip("originaldata.zip", exdir = "originaldata")

# read data
power_consumption_data <- read.table("./originaldata/household_power_consumption.txt",
                                     header = TRUE, sep = ";", dec = ".", na.strings="?")

# subset data since we will only be using data from the dates 2007-02-01 and 2007-02-02
selected_days <- power_consumption_data[power_consumption_data$Date %in% c("1/2/2007","2/2/2007"),]

# create datetime object of class POSIXlt
datetime <- strptime(paste(selected_days$Date, selected_days$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# create Plot 1
png("plot1.png", width = 480, height = 480)
hist(selected_days$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

############################################

# This R code file constructs the plot2.png plot

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset_file <- file.path(getwd(), "./originaldata.zip")
download.file(dataset_url, dataset_file)
unzip("originaldata.zip", exdir = "originaldata")

# read data
power_consumption_data <- read.table("./originaldata/household_power_consumption.txt",
                                     header = TRUE, sep = ";", dec = ".", na.strings="?")

# subset data since we will only be using data from the dates 2007-02-01 and 2007-02-02
selected_days <- power_consumption_data[power_consumption_data$Date %in% c("1/2/2007","2/2/2007"),]

# create datetime object of class POSIXlt
datetime <- strptime(paste(selected_days$Date, selected_days$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# create Plot 2
png("plot2.png", width = 480, height = 480)
plot(x = datetime, y = selected_days$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

############################################

# This R code file constructs the plot3.png plot

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset_file <- file.path(getwd(), "./originaldata.zip")
download.file(dataset_url, dataset_file)
unzip("originaldata.zip", exdir = "originaldata")

# read data
power_consumption_data <- read.table("./originaldata/household_power_consumption.txt",
                                     header = TRUE, sep = ";", dec = ".", na.strings="?")

# subset data since we will only be using data from the dates 2007-02-01 and 2007-02-02
selected_days <- power_consumption_data[power_consumption_data$Date %in% c("1/2/2007","2/2/2007"),]

# create datetime object of class POSIXlt
datetime <- strptime(paste(selected_days$Date, selected_days$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# create Plot 3
png("plot3.png", width = 480, height = 480)
plot(x = datetime, y = selected_days$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = datetime, y = selected_days$Sub_metering_2, col = "red")
lines(x = datetime, y = selected_days$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, lwd = 1)
dev.off()

#############################################

# This R code file constructs the plot4.png plot

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset_file <- file.path(getwd(), "./originaldata.zip")
download.file(dataset_url, dataset_file)
unzip("originaldata.zip", exdir = "originaldata")

# read data
power_consumption_data <- read.table("./originaldata/household_power_consumption.txt",
                                     header = TRUE, sep = ";", dec = ".", na.strings="?")

# subset data since we will only be using data from the dates 2007-02-01 and 2007-02-02
selected_days <- power_consumption_data[power_consumption_data$Date %in% c("1/2/2007","2/2/2007"),]

# create datetime object of class POSIXlt
datetime <- strptime(paste(selected_days$Date, selected_days$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# create Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(x = datetime, y = selected_days$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(x = datetime, y = selected_days$Voltage, type = "l", ylab = "Voltage")

plot(x = datetime, y = selected_days$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = datetime, y = selected_days$Sub_metering_2, col = "red")
lines(x = datetime, y = selected_days$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, lwd = 1, bty = "n")

plot(x = datetime, y = selected_days$Global_reactive_power, type = "l", ylab = "Global_reactive_power")

dev.off()