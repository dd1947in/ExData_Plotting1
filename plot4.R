plot4 <- function() {
  library(dplyr)
  #Data file is saved one level above the working directory
  file_hpc <- "../household_power_consumption.txt" 
  cc <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
  #read table / data frame
  df_hpc <- read.table(file_hpc, sep= ";", header=TRUE, colClasses = cc, na.strings = "?")
  #filter rows
  df_hpc <- filter(df_hpc,  Date == "1/2/2007" | Date == "2/2/2007")
  #prepare Time for POSIXlt
  df_hpc$Time <- paste(df_hpc$Date, df_hpc$Time)
  #convert Date/Time to classes
  df_hpc$Date <- as.Date(df_hpc$Date, format="%d/%m/%Y")
  df_hpc$Time <- strptime(df_hpc$Time, format="%d/%m/%Y %H:%M:%S")
  
  gap <- df_hpc$Global_active_power
  png(filename = "plot4.png",    width = 960, height = 960, units = "px", pointsize = 12,    bg = "white", res = NA, family = "", restoreConsole = TRUE,    type = c("windows", "cairo", "cairo-png"))
  
  par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  with(df_hpc, {
    plot(Time, Global_active_power, type="l", xlab="Date Time", ylab="Global active power")
    plot(Time, Voltage, type="l", xlab="Date Time", ylab="Voltage")
    plot(Time, Sub_metering_1, type="n", xlab="Date Time", ylab="Energy sub metering")
    lines(Time, Sub_metering_1,   col="black")
    lines(Time, Sub_metering_2,   col="orange")
    lines(Time, Sub_metering_3,   col="blue")
    legend("topright", pch = 8, col = c("black", "orange", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Time, Global_reactive_power, type="l", xlab="Date Time", ylab="Global reactive power")
    mtext("Plot 4 : Electric Power Consumption", outer = TRUE)  
  })  
  dev.off()
}
plot4()
