# load library's needed
library(dplyr)
library(ggplot2)
library(stringr)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check for null values
# mean(is.na(NEI$Emissions)) + mean(is.na(NEI$fips)) + mean(is.na(NEI$SCC)) + mean(is.na(NEI$Pollutant)) + mean(is.na(NEI$Emissions)) + mean(is.na(NEI$type)) + mean(is.na(NEI$year))
# there are no missing values 
if (mean(is.na(NEI$Emissions)) + mean(is.na(NEI$fips)) + mean(is.na(NEI$SCC)) + mean(is.na(NEI$Pollutant)) + mean(is.na(NEI$Emissions)) + mean(is.na(NEI$type)) + mean(is.na(NEI$year)) > 0)
    print("missing values present") else print("no missing values")
end

# subset coal data
# SCC_COAL <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
SCC_COAL <- SCC %>% filter(str_detect(EI.Sector,regex('comb.*coal', ignore_case = T)))

# Merge NIE and SCC coal data
COAL_EMISSION <- merge(NEI, SCC_COAL, by = "SCC")

# calculate sums
COAL_EMISSIONS_YEAR <- with(COAL_EMISSION, tapply(Emissions/1000, year, sum))

DF_COAL_EMISSIONS_YEAR <- data.frame(YEAR = as.integer(names(COAL_EMISSIONS_YEAR)), TOT_EMISSION = COAL_EMISSIONS_YEAR)

# ggplot
g<- ggplot(DF_COAL_EMISSIONS_YEAR, aes(YEAR,TOT_EMISSION)) + 
    geom_line(col = "steelblue") + ylim(0,NA) + geom_point() + 
    labs( y = expression("Emissions of PM" [2.5] * " in kilotons")) + 
    ggtitle ("Emissions from coal combustion-related sources accross U.S.")
print(g)
dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
