library("rjson")
library("txtplot")

# initializations
data.dir <- "data"
fig.dir <- "fig"

# get most recent exeter file
ex.files <- dir(data.dir, full.names=TRUE)
ex.files <- grep("exeter-", ex.files, value=TRUE)
data.file <- tail(sort(ex.files), 1)

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

# initialize plot filename
plot.file1 <- strsplit(data.file, "/")[[1]][2]
plot.file1 <- strsplit(plot.file1, "\\.")[[1]][1]

# "production time" of the plot
N <- length(time)
prod.time <- paste(strsplit(plot.file1, "-")[[1]][-1], collapse="")
prod.time <- as.POSIXlt(prod.time, format="%Y%m%d%H%M")
prod.time <- format.Date(prod.time, "%d %b %H:%M")

# txtplot
txt.file <- paste(fig.dir, "/", plot.file1, ".txt", sep="")
sink(file=txt.file)
cat("\n\n")
cat("Probability of precipitation for Exeter, Devon, UK\n")
cat("last update: ", prod.time, "\n\n\n")
txtplot(1:N, prcp.prob, xlim=c(1,N), ylim=c(-.1, 1.1), xlab="lead time [min]")
cat("\n\n")
sink()

# save filename
cmd <- paste("echo", txt.file, ">> MOSTRECENT")
system(cmd)

