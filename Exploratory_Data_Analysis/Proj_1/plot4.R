#Project_1 Exploratory_Data_Analisys
Sys.setlocale("LC_ALL", "English")

# Check&Load library Pakcages

check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("data.table","utils")
check.packages(packages)

#Get data from URL and unpack

path <- getwd()
if (!file.exists("./household_power_consumption.txt")){
  datalink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(datalink, file.path(path, "exdata_data_household_power_consumption.zip"))
  unzip(zipfile = "exdata_data_household_power_consumption.zip")}
options(scipen = 999) #No scientific notation
#Read data set
powerData <- read.csv(file.path(path, "./household_power_consumption.txt"),sep = ";", na.strings = "?")
estm <- format(object.size(powerData), units = "auto") #Rough estimate of memory usage
print(estm)
#Date column to date class
datetime <-  paste(powerData$Date, powerData$Time)
datetime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
powerData <- cbind(datetime, powerData)
#Select desired interval
powerDataSub <- subset(powerData, subset = (datetime >= "2007-02-01") & (datetime < "2007-02-03")) 
#Plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#Plot1
plot(powerDataSub$datetime, powerDataSub$Global_active_power, type = "l", xlab = " ", ylab = "Global active power")
#Plot2
plot(powerDataSub$datetime, powerDataSub$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#Plot3
plot(powerDataSub$datetime, powerDataSub$Sub_metering_1, type="l", xlab = " ", ylab = "Energy sub metering")
lines(powerDataSub$datetime, powerDataSub$Sub_metering_2, col = "red")
lines(powerDataSub$datetime, powerDataSub$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1)
)
#Plot4
plot(powerDataSub$datetime, powerDataSub$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
