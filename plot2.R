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
png("plot2.png")
plot.ts(powerSubset$Global_active_power, xlab = NA, ylab = "Global Active Power (kilowatts)", axes = FALSE)
axis(2)
axis(1, at = c(0, (length(powerSubset$Global_active_power)/2), (length(powerSubset$Global_active_power))), labels = c("Thu", "Fri", "Sat"))
box(which = "plot")
dev.off()