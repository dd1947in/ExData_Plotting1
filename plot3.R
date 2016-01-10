plot3 <- function() {
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
  png(filename = "plot3.png",    width = 480, height = 480, units = "px", pointsize = 12,    bg = "white", res = NA, family = "", restoreConsole = TRUE,    type = c("windows", "cairo", "cairo-png"))
  #hist(gap, ylab="Frequency", xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
  #plot(df_hpc$Time, df_hpc$Global_active_power, type="l", xlab="Time", ylab="Global active power (kilowatts)")
  plot(df_hpc$Time, df_hpc$Sub_metering_1, type="n", xlab="Date Time", ylab="Energy sub metering")
  lines(df_hpc$Time, df_hpc$Sub_metering_1,   col="black")
  lines(df_hpc$Time, df_hpc$Sub_metering_2,   col="orange")
  lines(df_hpc$Time, df_hpc$Sub_metering_3,   col="blue")
  legend("topright", pch = 8, col = c("black", "orange", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}
plot3()
