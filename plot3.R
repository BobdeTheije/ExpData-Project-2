# load library's needed
library(dplyr)
library(ggplot2)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check for null values
# mean(is.na(NEI$Emissions)) + mean(is.na(NEI$fips)) + mean(is.na(NEI$SCC)) + mean(is.na(NEI$Pollutant)) + mean(is.na(NEI$Emissions)) + mean(is.na(NEI$type)) + mean(is.na(NEI$year))
# there are no missing values 
if (mean(is.na(NEI$Emissions)) + mean(is.na(NEI$fips)) + mean(is.na(NEI$SCC)) + mean(is.na(NEI$Pollutant)) + mean(is.na(NEI$Emissions)) + mean(is.na(NEI$type)) + mean(is.na(NEI$year)) > 0)
    print("missing values present") else print("no missing values")
end

# subset Baltimore data
NEI_BALTIMORE <- subset(NEI, fips == "24510")

# group by type and year
NEI_BAL_TYPE_YEAR <- group_by(NEI_BALTIMORE, type, year)

# summarize data
NEI_BAL_TYPE_YEAR_SUM <- summarize(NEI_BAL_TYPE_YEAR, Tot_Emissions = sum(Emissions))

# qplot
g <- qplot(year, Tot_Emissions, data = NEI_BAL_TYPE_YEAR_SUM, color = type, geom = "line"
      ,ylab = "Total Emissions of PM2.5 in tons"
      ,main = "Total Emissions of PM2.5 in Baltimore")
print(g)

dev.copy(png, file = "plot3.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
