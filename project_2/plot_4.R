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

# Plot 4
# name: # Trend across the United States,  from coal combustion-related sources
# use: bar plot
# column: aggregated total
# include units in title
# write the output in png format
# build a full path
filePath = file.path(folder, "plot4.png", fsep = .Platform$file.sep)

# Create a subset for coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# from 1999 to 2008
combustionNEIData <- combustionNEI[combustionNEI$year>="1999" & combustionNEI$year<="2008",]

# Open PNG device
png(filePath, width=width, height=height, units=units, bg="transparent")

# display using ggplot 
ggp <- ggplot(combustionNEIData, aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity", fill="grey", width=0.75) + theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

# close device
dev.off()