# step 0: load packages
library(tidyverse)
library(ggplot2)

# read in data (plot1.R will provide the data)
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25<-readRDS("./data/summarySCC_pm25.rds")

# create data set that combines the source of the pollutant by the scc code 
# i will only use the short name as the source
# first subset the sources that have coal in the short name
poll_source <- classcode[grep("Coal", classcode$Short.Name),] %>% 
  select(SCC,Short.Name)

# then inner join to the pollution data so we only coal source pollution
coal_poll <- inner_join(pm25, poll_source, by="SCC") %>%
  group_by(year) %>% summarise(pmTotal=sum(Emissions)/100000)

# create plot of emissions by year using the coal pollution data
ggplot() +
  geom_point(data=coal_poll,aes(x=year,y=pmTotal))+
  geom_line(data=coal_poll[1:2,],aes(x=year,y=pmTotal),col="green")+
  geom_line(data=coal_poll[2:3,],aes(x=year,y=pmTotal),col="red")+
  geom_line(data=coal_poll[3:4,],aes(x=year,y=pmTotal),col="green")+
  geom_line(data=coal_poll[c(1,4),],aes(x=year,y=pmTotal),col="green")+
  labs(x="Year",y="Emissions (in hundred thousand Tons)",title="US Coal Pollution Emissions")+
  theme(legend.position="right")

  

# ANSWER: The emissions of pm25 with coal sources decreaes overall over time from 1999 to 2008

dev.copy(png, "plot4.png")
dev.off()

