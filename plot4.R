
# cleaning the global environment
rm(list=ls(envir = .GlobalEnv), envir = .GlobalEnv)

# choosing and going to the working directory to work with
wdDir <- dirname(choose.files())
setwd(wdDir)

# downloading the file from the course website and unzipping it
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("hpc.zip")) download.file(fileUrl, destfile="hpc.zip")
if (!file.exists("household_power_consumption.txt")) unzip("hpc.zip")

# loading the packages needed
pkg   <- c("lubridate")
for (i in pkg) {
   if(i %in% rownames(installed.packages()) == FALSE) {install.packages(i)}
   library(i, character.only = TRUE)
}

# reading the hpc file and creating a data frame table
hpc <- tbl_df(read.table("household_power_consumption.txt", na.strings=c('?'), header=TRUE, sep=";"))

# converting data types and filtering the data to be used
hpc$Date  <- dmy(hpc$Date)
tmp_date_time <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(tmp_date_time, tz="UTC")
hpc2 <- hpc[hpc$Date == dmy("01/02/2007") | hpc$Date == dmy("02/02/2007"),]

# Plotting graph 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(hpc2, {
   plot(Global_active_power~Datetime, type = "l", 
        ylab = "Global Active Power (kilowatts)", xlab = "")
   plot(Voltage~Datetime, type = "l", 
        ylab = "Voltage (volt)", xlab = "")
   plot(Sub_metering_1~Datetime, type = "l", 
        ylab = "Global Active Power (kilowatts)", xlab = "")
   lines(Sub_metering_2~Datetime, col = 'Red')
   lines(Sub_metering_3~Datetime, col = 'Blue')
   legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
   plot(Global_reactive_power~Datetime, type = "l", 
        ylab = "Global Rective Power (kilowatts)", xlab = "")
})

# generating the png file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()