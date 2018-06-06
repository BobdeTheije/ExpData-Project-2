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
NEIBALTIMORE <- subset(NEI, fips == "24510")

# calculate sums of Emissions per year
TOT_EMISSIONS_BAL_YEAR <- with(NEIBALTIMORE, tapply(Emissions, year, sum))

# barplot
barplot(TOT_EMISSIONS_BAL_YEAR, xlab = "Year", ylab = "Total emissions from PM2.5 in tons", main = "Total emissions from PM2.5 (tons) in Baltimore", col = c("red","blue","green","yellow"))

dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
