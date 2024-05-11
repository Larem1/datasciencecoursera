# step 0: load packages
library(tidyverse)
library(ggplot2)

# read in data (plot1.R will provide the data)
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25<-readRDS("./data/summarySCC_pm25.rds")

# use the same mobil source codes from plot5.R
mobile_source <- classcode %>% filter(SCC.Level.One=="Mobile Sources") %>%
  select(SCC, Short.Name)

# filter the pollution data to only have baltimore and Los Angeles data
balt_LA <- pm25 %>% filter(fips %in% c("24510", "06037"))

# inner join the mobile codes to the baltimore and LA data 
balt_LA_mobile <- inner_join(balt_LA, mobile_source,by="SCC") %>%
  group_by(year,fips) %>% summarise(Totpm = sum(Emissions))

# create the right categories for the fips column
balt_LA_mobile <- balt_LA_mobile %>%
  mutate(fips = as.factor(fips),City = levels(fips)<-c("LA", "Baltimore"))

# creat the plot that shows both cities emission each year
ggplot(balt_LA_mobile)+
  geom_line(aes(x=year, y=Totpm, col=City),lwd=2)+
  labs(x="Year", y="Emissions (in Tons)", title="Baltimore vs LA Emissions 1999-2008")

# ANSWER: Both emissions from LA and Baltimore are similar but
# the LA line is slightly flatter meaning it has seen less change over time
# (steeper lines = more change) the baltimore line is also well above the LA line
# more than 10 thousand tons above

dev.copy(png, "plot6.png")
dev.off()
