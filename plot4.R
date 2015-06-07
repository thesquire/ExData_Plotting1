library(downloader)     ## load package to use unzip function

## download files from internet and create folder in working directory if it doesn't already exist
if (!file.exists("./4CourseProject1")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download(fileURL, dest = "4CourseProject1.zip", mode = "wb")
        unzip("4CourseProject1.zip", exdir = "./4CourseProject1")
        dateDownloaded <- date()
}

## read in data, convert Date column to appropriate format, and subset dates
powerConsumption <- read.table("./4CourseProject1/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
powerConsumption$Date <- as.Date(powerConsumption$Date, "%d/%m/%Y")
powerSubset <- powerConsumption[(powerConsumption$Date == "2007-02-01" | powerConsumption$Date == "2007-02-02"), ]

## create plots and save to file
png("plot4.png")
par(mfcol = c(2,2))

## top-left plot
plot.ts(powerSubset$Global_active_power, xlab = NA, ylab = "Global Active Power (kilowatts)", axes = FALSE)
axis(2)
axis(1, at = c(0, (length(powerSubset$Global_active_power)/2), (length(powerSubset$Global_active_power))), labels = c("Thu", "Fri", "Sat"))
box(which = "plot")

## bottom-left plot
plot.ts(powerSubset$Sub_metering_1, xlab = NA, ylab = "Energy sub metering", axes = FALSE, col = "black")
axis(2)
axis(1, at = c(0, (length(powerSubset$Global_active_power)/2), (length(powerSubset$Global_active_power))), labels = c("Thu", "Fri", "Sat"))
par(new = TRUE)
plot.ts(powerSubset$Sub_metering_2, xlab = NA, ylab = NA, axes = FALSE, col = "red", ylim = c(0, 30))
par(new = TRUE)
plot.ts(powerSubset$Sub_metering_3, xlab = NA, ylab = NA, axes = FALSE, col = "blue", ylim = c(0, 30))
legend('topright', lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = 'n')
box(which = "plot")

## top-right plot
plot.ts(powerSubset$Voltage, xlab = "datetime", ylab = "Voltage", axes = FALSE, ylim = c(234, 246))
axis(2, at = c(234, 238, 242, 246))
axis(2, at = c(236, 240, 244), labels = FALSE)
axis(1, at = c(0, (length(powerSubset$Global_active_power)/2), (length(powerSubset$Global_active_power))), labels = c("Thu", "Fri", "Sat"))
box(which = "plot")

## bottom-right plot
plot.ts(powerSubset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", axes = FALSE)
axis(2)
axis(1, at = c(0, (length(powerSubset$Global_active_power)/2), (length(powerSubset$Global_active_power))), labels = c("Thu", "Fri", "Sat"))
box(which = "plot")

dev.off()