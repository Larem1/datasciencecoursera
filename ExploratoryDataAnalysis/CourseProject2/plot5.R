# step 0: load packages
library(tidyverse)
library(ggplot2)

# read in data (plot1.R will provide the data)
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25<-readRDS("./data/summarySCC_pm25.rds")

# create the data set that contains motor vehicle emissions in baltimore city
# first grab the codes that correspond to "Mobile Sources" as SCC Level One
mobile_source <- classcode %>% filter(SCC.Level.One=="Mobile Sources") %>%
  select(SCC, Short.Name) 

# filter the pollution data to only baltimore and inner join the mobile source codes
baltimore_mobil <- pm25 %>% filter(fips=="24510") %>%
  inner_join(.,mobile_source,by="SCC") %>% group_by(year) %>%
  summarise(Totpm=sum(Emissions))

# Create a the plot that shows the total emissions for each year
ggplot() +
  geom_point(data=baltimore_mobil,aes(x=year,y=Totpm))+
  geom_line(data=baltimore_mobil[1:2,],aes(x=year,y=Totpm),col="green")+
  geom_line(data=baltimore_mobil[2:3,],aes(x=year,y=Totpm),col="red")+
  geom_line(data=baltimore_mobil[3:4,],aes(x=year,y=Totpm),col="red")+
  geom_line(data=baltimore_mobil[c(1,4),],aes(x=year,y=Totpm),col="green")+
  labs(x="Year",y="Emissions (in Tons)",title="Baltimore Coal Pollution Emissions")+
  theme(legend.position="right")

# ANSWER: The pollution emissions from motor vehicles decreased greatly
# from 1999 to 2002 then slightly increased from 2002 to 2005 and to 2008
# but overall it was still a decrease.

dev.copy(png, "plot5.png")
dev.off()


