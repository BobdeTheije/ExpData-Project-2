# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check for null values
# mean(is.na(NEI$Emissions)) + mean(is.na(NEI$fips)) + mean(is.na(NEI$SCC)) + mean(is.na(NEI$Pollutant)) + mean(is.na(NEI$Emissions)) + mean(is.na(NEI$type)) + mean(is.na(NEI$year))
# there are no missing values 
if (mean(is.na(NEI$Emissions)) + mean(is.na(NEI$fips)) + mean(is.na(NEI$SCC)) + mean(is.na(NEI$Pollutant)) + mean(is.na(NEI$Emissions)) + mean(is.na(NEI$type)) + mean(is.na(NEI$year)) > 0)
    print("missing values present") else print("no missing values")
end

# calculate sums of Emissions per year
TOT_EMISSIONS_YEAR <- with(NEI, tapply(Emissions/1000, year, sum))

# barplot
barplot(TOT_EMISSIONS_YEAR, xlab = "Year", ylab = "Total emissions from PM2.5 in Kilotons", main = "Total emissions from PM2.5 in United States", col = c("red","blue","green","yellow"))


dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!