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

# Plot 3
# name: # trend for total emissions from PM2.5 in the Baltimore City, Maryland
# use: bar plot
# column: aggregated total
# include units in title
# write the output in png format
# build a full path
filePath = file.path(folder, "plot3.png", fsep = .Platform$file.sep)

# Subset NEI data by Baltimore City, Maryland fip.
baltimoreNEIData <- NEI[NEI$fips=="24510",]

# from 1999 to 2008
baltimoreNEIData <- baltimoreNEIData[baltimoreNEIData$year>="1999" & baltimoreNEIData$year<="2008",]

# Open PNG device
png(filePath, width=width, height=height, units=units, bg="transparent")

# display using ggplot 
ggp <- ggplot(baltimoreNEIData, aes(factor(year), Emissions, fill=type)) + geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE) + facet_grid(.~type, scales ="free", space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

# close device
dev.off()