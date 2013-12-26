library("rjson")
library("txtplot")

# temporary files as defined in main bash script
tmpfile <- "/tmp/exeterforecastio.tmp"
tmpplotfile_temp48 <- "/tmp/exetertemp48_plot.tmp"

# get most recent exeter file
data.file <- readLines(tmpfile)

# create list from JSON object
j <- fromJSON(readLines(data.file, warn=FALSE))

# get 'hourly' data 
hourly.list <- j[["hourly"]][["data"]]

# get temperature in celsius
temp <- sapply(hourly.list, `[[`, "temperature")
temp <- (temp - 32) * 5 / 9

# get time codes
time <- sapply(hourly.list, `[[`, "time")
# unix time to real time
time <- as.POSIXct(time, origin="1970-01-01", tz="London")

# "production time" of the plot
N <- length(time)
last.update.time <- paste(file.info(data.file)[["mtime"]])

# txtplot
sink(file=tmpplotfile_temp48)
cat("\n\n")
cat("48 hour temperature forecast for Exeter, Devon, UK\n")
cat("last update: ", last.update.time, "\n\n\n")
txtplot(1:N, temp, xlim=c(1,N), ylim=range(temp)+c(-1,1), xlab="lead time [hours]")
cat("\n\n")
sink()

