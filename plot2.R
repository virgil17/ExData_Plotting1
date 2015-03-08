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
 
  # Extract the required date range.
  hpow <- hpowsrc[ which(hpowsrc$Date == as.Date("2007-02-01") | hpowsrc$Date == as.Date("2007-02-02")), ]

  # Generate the line graph.
  plot(x=hpow$DateTime, y=hpow$Global_active_power, 
       xlab="",
       ylab="Global Active Power (kilowatts)", 
       type="n")
  lines(x=hpow$DateTime, y=hpow$Global_active_power)

  dev.copy(png, filename="plot2.png", width=480, height=480, units="px")
  dev.off()
}

gen_plot
