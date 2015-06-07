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

## create plot and save to file
png("plot3.png")
plot.ts(powerSubset$Sub_metering_1, xlab = NA, ylab = "Energy sub metering", axes = FALSE, col = "black")
axis(2)
axis(1, at = c(0, (length(powerSubset$Global_active_power)/2), (length(powerSubset$Global_active_power))), labels = c("Thu", "Fri", "Sat"))
par(new = TRUE)
plot.ts(powerSubset$Sub_metering_2, xlab = NA, ylab = NA, axes = FALSE, col = "red", ylim = c(0, 30))
par(new = TRUE)
plot.ts(powerSubset$Sub_metering_3, xlab = NA, ylab = NA, axes = FALSE, col = "blue", ylim = c(0, 30))
legend('topright', lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
box(which = "plot")
dev.off()