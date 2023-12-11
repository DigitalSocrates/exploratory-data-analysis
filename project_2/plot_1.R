## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("H:\\workspace\\exploratory-data-analysis\\project_2\\data\\summarySCC_PM25.rds")
SCC <- readRDS("H:\\workspace\\exploratory-data-analysis\\project_2\\data\\Source_Classification_Code.rds")

# set global params for image widdth and height, and units
width = 480
height = 480
units = "px"

# folder 
folder = "H:\\workspace\\exploratory-data-analysis\\project_2\\"

# Plot 1
# name: # Trend for total emissions from PM2.5 in the United States from 1999 to 2008
# use: bar plot
# column: aggregated total
# include units in title
# write the output in png format

# build a full path
filePath = file.path(folder, "plot1.png", fsep = .Platform$file.sep)

aggEmissionsTotals <- aggregate(Emissions ~ year,NEI, sum)

# from 1999 to 2008
aggEmissionsTotals <- aggEmissionsTotals[aggEmissionsTotals$year>="1999" & aggEmissionsTotals$year<="2008",]

# Open PNG device
png(filePath, width=width, height=height, units=units, bg="transparent")

# display using barplot 
barplot(
  (aggEmissionsTotals$Emissions)/10^6,
  names.arg=aggEmissionsTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

# close device
dev.off()