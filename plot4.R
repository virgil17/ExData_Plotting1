gen_plot <- {
  # Read in the dataset from the file.
  hpowsrc <- read.csv("household_power_consumption.txt", sep=";")

  # Create the date-time column and add it to the data frame.
  # Convert the existing date column to datetime format.
  DateTime <- as.POSIXlt(paste(hpowsrc$Date, hpowsrc$Time), format="%d/%m/%Y %H:%M:%S")
  hpowsrc <- cbind(DateTime, hpowsrc)

  # Data format conversion for date and numeric columns.
  hpowsrc$Date <- as.Date(hpowsrc$Date, format="%d/%m/%Y")
  hpowsrc$Global_active_power <- as.numeric(as.character(hpowsrc$Global_active_power))
  hpowsrc$Global_reactive_power <- as.numeric(as.character(hpowsrc$Global_reactive_power))
  hpowsrc$Sub_metering_1 <- as.numeric(as.character(hpowsrc$Sub_metering_1))
  hpowsrc$Sub_metering_2 <- as.numeric(as.character(hpowsrc$Sub_metering_2))
  hpowsrc$Sub_metering_3 <- as.numeric(as.character(hpowsrc$Sub_metering_3))
  hpowsrc$Voltage <- as.numeric(as.character(hpowsrc$Voltage))
 
  # Extract the required date range.
  hpow <- hpowsrc[ which(hpowsrc$Date == as.Date("2007-02-01") | hpowsrc$Date == as.Date("2007-02-02")), ]


  # Set up the canvas.
  par(mfcol=c(2,2)) 


  # Generate line graph for Global Active Power.
  plot(x=hpow$DateTime, y=hpow$Global_active_power, 
       xlab="",
       ylab="Global Active Power (kilowatts)", 
       type="n")
  lines(x=hpow$DateTime, y=hpow$Global_active_power)

 
  # Generate the line graphs for each sub_meter.
  plot(x=hpow$DateTime, y=hpow$Sub_metering_1, 
       xlab="",
       ylab="Energy sub metering",
       type="n")
  lines(x=hpow$DateTime, y=hpow$Sub_metering_1, col="black")
  lines(x=hpow$DateTime, y=hpow$Sub_metering_2, col="red")
  lines(x=hpow$DateTime, y=hpow$Sub_metering_3, col="blue")
  legend("topright", 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=c("black","blue","red"),
         lty=c(1,1,1),
         lwd=c(1,1,1),
         pt.cex=1,
         cex=0.8,
         bty="n")


  # Generate the voltage graph.
  plot(x=hpow$DateTime, y=hpow$Voltage, 
       xlab="datetime",
       ylab="Voltage", 
       type="n")
  lines(x=hpow$DateTime, y=hpow$Voltage)


  # Generate the reactive graph.
  plot(x=hpow$DateTime, y=hpow$Global_reactive_power, 
       xlab="datetime",
       ylab="Global_reactive_power", 
       type="n")
  lines(x=hpow$DateTime, y=hpow$Global_reactive_power)


  # Save a copy to a png file.
  dev.copy(png, filename="plot4.png", width=480, height=480, units="px")
  dev.off()
}

gen_plot
