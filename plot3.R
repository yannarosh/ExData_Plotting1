makeplot3 <- function() {
        
        # Download files and unzip
        if(!file.exists("./data")) {
                dir.create("./data")
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                file_dest <- "./data/assignment_data.zip"
                message("downloading files...")
                download.file(url, file_dest)
                message("unzipping contents...")
                unzip("./data/assignment_data.zip", exdir = "./data")
                
                makeplot3()
                
        }
        
        else {
                message("reading data and drawing plot...")
                # Read table, convert Date to date format and create variable DateTime that holds the full date/time
                A <- read.table("./data/household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")
                Asub <- subset(A, Date %in% c("1/2/2007", "2/2/2007"))
                Asub$Date <- as.Date(Asub$Date, format = "%d/%m/%Y")
                Asub <- cbind(Asub, "DateTime" = as.POSIXct(paste(Asub$Date, Asub$Time)))
                
                # Create plot in plot3.png
                png(filename = "plot3.png", width = 480, height = 480)
                plot(Asub$Sub_metering_1 ~ Asub$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
                lines(Asub$Sub_metering_2 ~ Asub$DateTime, col = "red")
                lines(Asub$Sub_metering_3 ~ Asub$DateTime, col = "blue")
                legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                dev.off()
        }
        
        
}

