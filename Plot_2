install.packages("data.table")
library(data.table)

path <- getwd()

#download and unzip documents

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))

unzip(zipfile = "dataFiles.zip")

#read in files

NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

NEI_table <- data.table(NEI)
NEI_yearly <- NEI_table[fips=='24510',sum(Emissions),by=year]

#create a scatterplot
plot(NEI_yearly)

# Create a histogram
barplot(NEI_yearly[, V1], main = "Total Emissions by Year in Baltimore",
        ylab = "Total Emissions", xlab = "Year",names = NEI_yearly[, year])
