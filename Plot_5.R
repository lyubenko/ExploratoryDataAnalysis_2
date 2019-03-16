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

NEI_Baltimore <- NEI_table[fips=='24510']
SCC_motor_vehicle_sources<- grepl("Vehi", SCC_table[, SCC.Level.Two], ignore.case=TRUE)

SCC_mvs<-SCC_table[SCC_motor_vehicle_sources,SCC]

NEI_motor_vehicle_sources_Baltimore<-NEI_Baltimore[NEI_Baltimore[,SCC] %in% SCC_mvs]



#create a plot

ggplot(NEI_motor_vehicle_sources_Baltimore,aes(factor(year),Emissions))+
  geom_bar(stat="identity", fill="red")+ 
  labs(title=expression("PM"[2.5]*" Emissions in Baltimore by Year due to Motor Vehiles"))+
  labs(x="Year", y=expression("Total Emission (Tons)"))

