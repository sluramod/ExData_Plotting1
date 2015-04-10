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

plot3 <- function() {
  x <- getdata()
  png(file="plot3.png", width=480, height=480, bg="white")
  plot(x = x$DateTime, y = x$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering")
  lines(x = x$DateTime, y = x$Sub_metering_2, col = "red")
  lines(x = x$DateTime, y = x$Sub_metering_3, col = "blue")
  legend("topright", legend=c("sub metering 1", "sub metering 2", "sub metering 3"), col=c("black", "red", "blue"), text.col = c("black", "red", "blue"), lty=c(1,1,1))
  dev.off()
}
