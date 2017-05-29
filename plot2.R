makeplot2 <- function() {
        
        # Download files and unzip
        if(!file.exists("./data")) {
                dir.create("./data")
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                file_dest <- "./data/assignment_data.zip"
                message("downloading files...")
                download.file(url, file_dest)
                message("unzipping contents...")
                unzip("./data/assignment_data.zip", exdir = "./data")
                
                makeplot2()
        }
        
        else {
                message("reading data and drawing plot...")
                # Read table, convert Date to date format and create variable DateTime that holds the full date/time
                A <- read.table("./data/household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")
                Asub <- subset(A, Date %in% c("1/2/2007", "2/2/2007"))
                Asub$Date <- as.Date(Asub$Date, format = "%d/%m/%Y")
                Asub <- cbind(Asub, "DateTime" = as.POSIXct(paste(Asub$Date, Asub$Time)))
                
                # Create plot in plot2.png
                png(filename = "plot2.png", width = 480, height = 480)
                plot(Asub$Global_active_power ~ Asub$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
                dev.off()
        }
        
        
}

