
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
tmp_date_time <- paste(as.Date(hpc2$Date), hpc2$Time)
hpc2$Datetime <- as.POSIXct(tmp_date_time, tz="UTC")
hpc2 <- hpc[hpc$Date == dmy("01/02/2007") | hpc$Date == dmy("02/02/2007"),]

      # Plotting graph 1
hist(hpc2$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

      # generating the png file 
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

