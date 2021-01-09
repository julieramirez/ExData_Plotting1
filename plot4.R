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

# plot 4  ---------------------------------------------------------------------------------------------

par(mfrow=c(2,2))
power.fin <- mutate(power.fin, datetime = ymd_hms(paste(Date, Time)))
# -----------------------------------------------------------------------------------------------------

plot(Global_active_power ~ datetime, power.fin, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)
# ------------------------------------------------------------------------------------------------------
plot(Voltage ~ datetime, power.fin, type = "l",
     ylab = "Voltage",
     xlab = "datatime")
# ----------------------------------------------------------------------------------------------------
plot(Sub_metering_1 ~ datetime, power.fin, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)
lines(Sub_metering_2 ~ datetime, power.fin, type = "l", col = "red")
lines(Sub_metering_3 ~ datetime, power.fin, type = "l", col = "blue")
legend("topright",
       col = c("black",
               "red",
               "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = 1,
       bty = "n",
       cex = 0.4)
# -----------------------------------------------------------------------------------------------------
plot(Global_reactive_power ~ datetime, power.fin, type = "l",
     ylab = "Global Reactive Power",
     xlab = "datatime")
# -----------------------------------------------------------------------------------------------------

dev.copy(png, "plot4.png",
         width  = 480)

dev.off()

# end -------------------------------------------------------------------------------------------------