getdata <- function() {
  if (exists("cached_x"))
    return(cached_x)
  household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)
  household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
  x <- household_power_consumption[household_power_consumption$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
  x$DateTime <- strptime(paste(x$Date, x$Time), format="%Y-%m-%d %H:%M:%S")
  cached_x <<-x
  x
}

plot2 <- function() {
  x <- getdata()
  png(file="plot2.png", width=480, height=480, bg="white")
  plot(x = x$DateTime, y = x$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
  dev.off()
}
