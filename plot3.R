gen_plot <- {
  # Read in the dataset from the file.
  hpowsrc <- read.csv("household_power_consumption.txt", sep=";")

  # Create the date-time column and add it to the data frame.
  # Convert the existing date column to datetime format.
  DateTime <- as.POSIXlt(paste(hpowsrc$Date, hpowsrc$Time), format="%d/%m/%Y %H:%M:%S")
  hpowsrc <- cbind(DateTime, hpowsrc)

  # Data format conversion for date and numeric columns.
  hpowsrc$Date <- as.Date(hpowsrc$Date, format="%d/%m/%Y")
  hpowsrc$Sub_metering_1 <- as.numeric(as.character(hpowsrc$Sub_metering_1))
  hpowsrc$Sub_metering_2 <- as.numeric(as.character(hpowsrc$Sub_metering_2))
  hpowsrc$Sub_metering_3 <- as.numeric(as.character(hpowsrc$Sub_metering_3))
 
  # Extract the required date range.
  hpow <- hpowsrc[ which(hpowsrc$Date == as.Date("2007-02-01") | hpowsrc$Date == as.Date("2007-02-02")), ]

  # Generate the line graphs for each sub_meter.
  plot(x=hpow$DateTime, y=hpow$Sub_metering_1, 
       xlab="",
       ylab="Energy sub metering",
       type="n")
  lines(x=hpow$DateTime, y=hpow$Sub_metering_1, col="black")
  lines(x=hpow$DateTime, y=hpow$Sub_metering_2, col="red")
  lines(x=hpow$DateTime, y=hpow$Sub_metering_3, col="blue")

  # Create the legend.
  legend("topright", 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=c("black","blue","red"),
         lty=c(1,1,1),
         lwd=c(2.5, 2.5, 2.5),
         pt.cex=1,
         cex=0.8,
         seg.len=0.8)


  # Save a copy to a png file.
  dev.copy(png, filename="plot3.png", width=480, height=480, units="px")
  dev.off()
}

gen_plot
