library("rjson")
library("txtplot")

# temporary files as defined in main bash script
tmpfile_precip <- "/tmp/exeterforecastio.tmp" 
tmpplotfile_precip <- "/tmp/exeterprecip_plot.tmp"

# get most recent exeter file
data.file <- readLines(tmpfile_precip)

# create list from JSON object
j <- fromJSON(readLines(data.file, warn=FALSE))

# get 'minutely' data 
minu.list <- j[["minutely"]][["data"]]

# get precip probability
prcp.prob <- sapply(minu.list, `[[`, "precipProbability")

# get precip intensity
prcp.int <- sapply(minu.list, `[[`, "precipIntensity")

# get time codes
time <- sapply(minu.list, `[[`, "time")
# unix time to real time
time <- as.POSIXct(time, origin="1970-01-01", tz="London")

# "production time" of the plot
N <- length(time)
last.update.time <- paste(file.info(data.file)[["mtime"]])

# txtplot
sink(file=tmpplotfile_precip)
cat("\n\n")
cat("Probability of precipitation for Exeter, Devon, UK\n")
cat("last update: ", last.update.time, "\n\n\n")
txtplot(1:N, prcp.prob, xlim=c(1,N), ylim=c(-.1, 1.1), xlab="lead time [min]")
cat("\n\n")
sink()

