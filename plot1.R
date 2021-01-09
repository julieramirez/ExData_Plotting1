# Project 1 week 1 Exploratory Data Analysis --------------------------------------------------------

# Create data directory -----------------------------------------------------------------------------

if(!dir.exists("data")) { dir.create("data") }

# Download and unzip data file

file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

# Load libraries ------------------------------------------------------------------------------------

library(dplyr)
library(lubridate)

# Subset data ( from 2007-02-01 to 2007-02-02) ------------------------------------------------------

power.dat<-read.table("./data/household_power_consumption.txt",header = TRUE,sep = ";")
power.dat$Global_active_power<-as.numeric(power.dat$Global_active_power)
power.dat$Global_reactive_power<-as.numeric(power.dat$Global_reactive_power)
power.dat$Voltage<-as.numeric(power.dat$Voltage)
power.dat$Global_intensity<-as.numeric(power.dat$Global_intensity)
power.dat$Sub_metering_1<-as.numeric(power.dat$Sub_metering_1)
power.dat$Sub_metering_2<-as.numeric(power.dat$Sub_metering_2)
power.dat$Sub_metering_3<-as.numeric(power.dat$Sub_metering_3)
power.dat$Date<-as.Date(power.dat$Date,format="%d/%m/%Y")
str(power.dat)

power.dat2<-tbl_df(power.dat)
power.dat2
power.fin<-filter(power.dat2,Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))
power.fin

# plot 1 ---------------------------------------------------------------------------------------------

hist(power.fin$Global_active_power,
     main="Global Active Power",
     xlab = "Global Active Power (Kilowatts)",
     ylab="Frecuency",
     col = "red")

dev.copy(png,file="plot1.png",width=480)
dev.off()

# end ------------------------------------------------------------------------------------------------

