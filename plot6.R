# load library's needed
library(dplyr)
library(ggplot2)
library(stringr)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset Baltimore city and Los Angelos county data
NEI_BAL_LA <- subset(NEI, fips == "24510"| fips == "06037")

# subset motor vehicle source
SCC_MOTOR <- SCC %>% filter(str_detect(SCC.Level.Two,regex('vehicle', ignore_case = T)))

# merge data to subset NEI_BALTIMORE
NEI_BAL_LA_MOTOR <- merge(NEI_BAL_LA, SCC_MOTOR, by = "SCC")

# calculate sums of Emissions per year
TOT_EMS <- group_by(NEI_BAL_LA_MOTOR, year, fips) %>% summarize(EMS = sum(Emissions)) %>% 
    mutate(US_County = case_when(fips == "24510" ~ "Baltimore city", fips == "06037" ~ "Los Angeles county"))
#plot the data
g <- qplot(year,EMS, data = TOT_EMS, color = US_County, geom=c("point","line"), 
           ylab = expression("Total PM"[2.5]*" Emission in Tons"))
print(g)

dev.copy(png, file = "plot6.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!