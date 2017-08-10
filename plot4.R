start_wd=getwd()
setwd(paste(start_wd, "/", "database", sep = ""))

url_file="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("Household_power_comsumption.zip")){
        download.file(url = url_file, destfile = "Household_power_comsumption.zip", mode = "wb")
        unzip(zipfile = "Household_power_comsumption.zip")
}

hpc = read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

setwd(start_wd)

library(lubridate)
hpc$Time=as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
hpc$Date=as.Date(x = hpc$Date, format="%d/%m/%Y")

hpc_feb=hpc[year(hpc$Date)=="2007"&month(hpc$Date)=="2"&(day(hpc$Date)=="1"|day(hpc$Date)=="2"),]

png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px")

par(oma = c(0,2,0,0), bg = "white", mfcol = c(2,2), cex = 0.7)

#-------1st graph--------------------------------------

plot(x = hpc_feb$Time,
     y = hpc_feb$Global_active_power,
     xlab = "",
     ylab = "Global Active Power",
     type = "n"
)

lines(x = hpc_feb$Time,
      y = hpc_feb$Global_active_power
)

#-------2nd graph--------------------------------------

plot(x = hpc_feb$Time,
     y = hpc_feb$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n"
)

lines(x = hpc_feb$Time,
      y = hpc_feb$Sub_metering_1,
      col = "black"
)

lines(x = hpc_feb$Time,
      y = hpc_feb$Sub_metering_2,
      col = "red"
)

lines(x = hpc_feb$Time,
      y = hpc_feb$Sub_metering_3,
      col = "blue"
)

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       bty = "n",
       col = c("black", "red", "blue"))

#-------3rd graph--------------------------------------

plot(x = hpc_feb$Time,
     y = hpc_feb$Voltage,
     xlab = "datetime",
     ylab = "Voltage",
     type = "n"
)

lines(x = hpc_feb$Time,
      y = hpc_feb$Voltage
)

#-------4th graph--------------------------------------

plot(x = hpc_feb$Time,
     y = hpc_feb$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "n"
)

lines(x = hpc_feb$Time,
      y = hpc_feb$Global_reactive_power
)

dev.off()

