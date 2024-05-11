# step 0: load packages
library(tidyverse)
library(ggplot2)

# read in data (plot1.R will provide the data)
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25<-readRDS("./data/summarySCC_pm25.rds")

# create data set for baltimore with total emissions by each type and for the years 1999 and 2008
typebaltpm<- pm25 %>% filter(fips=="24510",year %in%c("1999","2008")) %>% group_by(year,type) %>%
  summarise(Totalpm = sum(Emissions))

# create plot that shows comparison of 1999 to 2008 then facet to the other types
ggplot(typebaltpm)+
  geom_line(aes(x=year,y=Totalpm))+
  labs(x="Year",y="Total Emissions (in Tons)", title = "Baltimore City PM25 Emissions 1999 vs 2008")+
  facet_grid(.~type)

#ANSWER: Non-Road, Nonpoint and onroad deacreased from 1999 to 2008 but
#point type increased.

dev.copy(png, "plot3.png")
dev.off()


