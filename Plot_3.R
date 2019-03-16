install.packages("data.table")
library(data.table)
library(ggplot2)

path <- getwd()

#download and unzip documents

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))

unzip(zipfile = "dataFiles.zip")

#read in files

NEI <-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

NEI_table <- data.table(NEI)
NEI_Baltimore <- NEI_table[fips=='24510']

#create a plot

ggplot(NEI_Baltimore,aes(factor(year),Emissions, fill=TRUE))+ facet_wrap(~type)+
  geom_bar(stat="identity")+ 
  labs(title=expression("PM"[2.5]*" Emissions in Baltimore City by Year by Source Type"))+
  labs(x="Year", y=expression("Total Emission (Tons)"))
