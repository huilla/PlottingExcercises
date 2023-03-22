# This R code file constructs the plot1.png plot
# Question1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset_file <- file.path(getwd(), "./EPA.zip")
download.file(dataset_url, dataset_file)
unzip("EPA.zip", exdir = "EPA")

# read data
NEI <- readRDS("./EPA/summarySCC_PM25.rds")
SCC <- readRDS("./EPA/Source_Classification_Code.rds")

# aggregate total PM2.5 emissions by year
agg_emissions <- aggregate(Emissions ~ year, NEI, sum)

# create Plot 1
png("plot1.png")
par(mar = c(5, 6, 4, 2)) # adjust margins
barplot((agg_emissions$Emissions)/10^6, # change scale of y axis to million tons
        names.arg = agg_emissions$year,
        col = "wheat",
        main = expression("Total "~ PM[2.5]~ "emissions by year in the US"), cex.main = 1.5,
        ylab = expression("total "~   PM[2.5] ~ "emissions in million tons"),
        xlab = "year")
dev.off()

##################################################

# This R code file constructs the plot2.png plot
# Question2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset_file <- file.path(getwd(), "./EPA.zip")
download.file(dataset_url, dataset_file)
unzip("EPA.zip", exdir = "EPA")

# read data
NEI <- readRDS("./EPA/summarySCC_PM25.rds")
SCC <- readRDS("./EPA/Source_Classification_Code.rds")

# subset data and aggregate total PM2.5 emissions by year in Baltimore City
NEI_Baltimore <- NEI[NEI$fips=="24510",]
agg_Baltimore <- aggregate(Emissions ~ year, NEI_Baltimore, sum)

# create Plot 2
png("plot2.png")
par(mar = c(5, 6, 4, 2)) # adjust margins
barplot(agg_Baltimore$Emissions,
        names.arg = agg_Baltimore$year,
        col = "wheat",
        main = expression("Total "~ PM[2.5]~ "emissions by year in Baltimore City"), cex.main = 1.5,
        ylab = expression("total "~   PM[2.5] ~ "emissions in tons"),
        xlab = "year")
dev.off()

#################################################

# This R code file constructs the plot3.png plot
# Question3: Of the four types of sources indicated by the type variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset_file <- file.path(getwd(), "./EPA.zip")
download.file(dataset_url, dataset_file)
unzip("EPA.zip", exdir = "EPA")

# read data
NEI <- readRDS("./EPA/summarySCC_PM25.rds")
SCC <- readRDS("./EPA/Source_Classification_Code.rds")

# subset data
NEI_Baltimore <- NEI[NEI$fips=="24510",]

# required package
library(ggplot2)

# create Plot 3
png("plot3.png")
ggplot(NEI_Baltimore, aes(factor(year), Emissions, fill = type)) + 
        geom_bar(stat = "identity") +
        facet_wrap(.~type, scales = "free") +
        labs(x = "year", y = expression("total "~ PM[2.5]~ "emissions in tons")) +
        ggtitle(expression("Total "~ PM[2.5]~ "emissions by year and type in Baltimore City")) +
        theme(plot.title = element_text(size = 15, hjust = 0.5), legend.position = "none")
dev.off()

#################################################

# This R code file constructs the plot4.png plot
# Question4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset_file <- file.path(getwd(), "./EPA.zip")
download.file(dataset_url, dataset_file)
unzip("EPA.zip", exdir = "EPA")

# read data
NEI <- readRDS("./EPA/summarySCC_PM25.rds")
SCC <- readRDS("./EPA/Source_Classification_Code.rds")

# subset data

# Note: According to EPA "External combustion sources" include steam/electric generating plants, industrial boilers, and
# commercial and domestic combustion units. Coal, fuel oil, and natural gas are the major fossil fuels used by these sources.
# See more: https://www.epa.gov/air-emissions-factors-and-quantification/ap-42-fifth-edition-volume-i-chapter-1-external-0
# Thus coal combustion-related sources are interpreted to mean sources that
# 1) belong to "External Combustion Sources" in the variable SCC.Level.One
# 2) mention the word "Coal" in the variable SCC.Level.Three

combustion <- grepl("External Combustion Boilers", SCC$SCC.Level.One)
coal <- grepl("Coal", SCC$SCC.Level.Three)
coal_combustion <- (combustion & coal)

SCC_coal_comb <- SCC[coal_combustion,]$SCC
NEI_coal_comb <- NEI[NEI$SCC %in% SCC_coal_comb,]

# aggregate total PM2.5 emissions from coal combustion-related sources by year
agg_coal_comb <- aggregate(Emissions ~ year, NEI_coal_comb, sum)

# create Plot 4
png("plot4.png")
par(mar = c(5, 6, 4, 2)) # adjust margins
barplot((agg_coal_comb$Emissions)/10^3, # change scale of y axis to thousand tons
        names.arg = agg_coal_comb$year,
        col = "wheat",
        main = expression("Total "~ PM[2.5]~ "emissions from coal combustion-related sources"),
        ylab = expression("total "~   PM[2.5] ~ "emissions in thousand tons"),
        xlab = "year")
dev.off()

#################################################

# This R code file constructs the plot5.png plot
# Question5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset_file <- file.path(getwd(), "./EPA.zip")
download.file(dataset_url, dataset_file)
unzip("EPA.zip", exdir = "EPA")

# read data
NEI <- readRDS("./EPA/summarySCC_PM25.rds")
SCC <- readRDS("./EPA/Source_Classification_Code.rds")

# subset data

# Note: EPA lists on-road and nonroad vehicles in the category "Mobile Sources" in the variable SCC.Level.One.
# See more: https://www.epa.gov/mobile-source-pollution/how-mobile-source-pollution-affects-your-health#mobile-sources
# Thus motor vehicle sources are interpreted to mean what EPA calls mobile sources.

vehicle <- grepl("Mobile Sources", SCC$SCC.Level.One)

SCC_vehicle <- SCC[vehicle,]$SCC
NEI_vehicle <- NEI[NEI$SCC %in% SCC_vehicle,]

Baltimore_vehicle <- NEI_vehicle[NEI_vehicle$fips=="24510",]

# aggregate total PM2.5 emissions from motor vehicle sources in Baltimore City by year
agg_vehicle <- aggregate(Emissions ~ year, Baltimore_vehicle, sum)

# create Plot 5
png("plot5.png")
par(mar = c(5, 6, 4, 2)) # adjust margins
barplot(agg_vehicle$Emissions,
        names.arg = agg_vehicle$year,
        col = "wheat",
        main = expression("Total "~ PM[2.5]~ "emissions from mobile sources in Baltimore City"),
        ylab = expression("total "~   PM[2.5] ~ "emissions in tons"),
        xlab = "year")
dev.off()