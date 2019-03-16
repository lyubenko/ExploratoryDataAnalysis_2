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

SCC_table<-data.table(SCC)

SCC_combustion <- grepl("combustion", SCC_table[, SCC.Level.One], ignore.case=TRUE)
SCC_coal <- grepl("coal", SCC_table[, SCC.Level.Four], ignore.case=TRUE) 
union <- SCC_table[SCC_combustion&SCC_coal, SCC]
combustionNEI <- NEI_table[NEI_table[,SCC] %in% union]


#create a plot

ggplot(combustionNEI,aes(factor(year),Emissions))+
  geom_bar(stat="identity")+ 
  labs(title=expression("PM"[2.5]*" Emissions across the USA by Year due to Coal Combustion"))+
  labs(x="Year", y=expression("Total Emission (Tons)"))
