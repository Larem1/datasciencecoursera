#step 0 load packages
library(tidyverse)

#change working directory (comment out after)
setwd("C:/Users/Larem15/Documents/GitHub/JohnsHopkinsCourse/datasciencecoursera/ExploratoryDataAnalysis/CourseProject2")

#create data directory
dir.create("./data")

#download data to working directory as data.zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "data.zip")

#unzip data to data directory
unzip("data.zip", exdir = "./data")

#read in the data sets
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25<-readRDS("./data/summarySCC_pm25.rds")

#create data set with total pm25 for each year
totpm<-pm25 %>% group_by(year) %>%
  summarise(Totalpm = sum(Emissions))

#create the plot of total pm by year
plot(totpm$year,totpm$Totalpm/1000000,xlab = "Year", 
     ylab = "Total pm25 Emissions (in millions of Tons)", 
     main = "US Total PM Emmissions per Year")
axis(1, at = seq(1999,2008))
lines(totpm$year,totpm$Totalpm/1000000)

#ANSWER: The plot shows a decrease in emission totals over time

dev.copy(png, "plot1.png")
dev.off()


