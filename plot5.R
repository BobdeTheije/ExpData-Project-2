# load library's needed
library(dplyr)
library(ggplot2)
library(stringr)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset Baltimore data
NEI_BALTIMORE <- subset(NEI, fips == "24510")

# subset motor vehicle source
SCC_MOTOR <- SCC %>% filter(str_detect(SCC.Level.Two,regex('vehicle', ignore_case = T)))

# check for right data:  unique(SCC_MOTOR$EI.Sector), unique(SCC_MOTOR$SCC.Level.One)

# merge data to subset NEI_BALTIMORE

NEI_BALTIMORE_MOTOR <- merge(NEI_BALTIMORE, SCC_MOTOR, by = "SCC")

#plot the data
g<- ggplot(NEI_BALTIMORE_MOTOR,aes(factor(year),Emissions)) +
    geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
print(g)
dev.copy(png, file = "plot5.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!