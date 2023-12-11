# Import 
# install.packages('ggplot2')
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("H:\\workspace\\exploratory-data-analysis\\project_2\\data\\summarySCC_PM25.rds")
SCC <- readRDS("H:\\workspace\\exploratory-data-analysis\\project_2\\data\\Source_Classification_Code.rds")

# set global params for image widdth and height, and units
width = 480
height = 480
units = "px"

# folder 
folder = "H:\\workspace\\exploratory-data-analysis\\project_2\\"

# Plot 5
# name: # trend for emissions from motor vehicle sources from 1999–2008 in Baltimore City?
# use: bar plot
# column: aggregated total
# include units in title
# write the output in png format
# build a full path
filePath = file.path(folder, "plot5.png", fsep = .Platform$file.sep)

# Create the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEIData <- vehiclesNEI[vehiclesNEI$fips=="24510",]

# from 1999 to 2008
baltimoreVehiclesNEIData <- baltimoreVehiclesNEIData[baltimoreVehiclesNEIData$year>="1999" & baltimoreVehiclesNEIData$year<="2008",]

# Open PNG device
png(filePath, width=width, height=height, units=units, bg="transparent")

# display using ggplot 
ggp <- ggplot(baltimoreVehiclesNEIData, aes(factor(year), Emissions)) +
  geom_bar(stat="identity", fill="grey", width=0.75) + theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

# close device
dev.off()