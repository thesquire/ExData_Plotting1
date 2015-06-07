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
png("plot1.png")
hist(powerSubset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()