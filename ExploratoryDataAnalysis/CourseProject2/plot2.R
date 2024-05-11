# step 0: load packages
library(tidyverse)

# read in data (plot1.R will provide the data)
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25<-readRDS("./data/summarySCC_pm25.rds")

# create data set with total pm emissions by year for only Baltimore City
baltpm<- pm25 %>% filter(fips=="24510") %>% group_by(year) %>%
  summarise(Totalpm = sum(Emissions))

# create plot of total pm emission by each year for Baltimore
plot(baltpm$year,baltpm$Totalpm/1000,xlab = "Year", 
     ylab = "Total pm25 Emissions (in thousands of Tons)", 
     main = "Baltimore City Total PM Emmissions per Year")
axis(1, at = seq(1999,2008))
lines(baltpm$year,baltpm$Totalpm/1000)
lines(baltpm$year[c(1,4)],baltpm$Totalpm[c(1,4)]/1000, col = "red")
legend(x="topright",legend=c("Overall 1999-2008"),lty=1,col="red")
#ANSWER: decreased from 1999 to 2002 and 2005 to 2008, increased from 2002 to 2005 
#but overall it decreased from 1999 to 2008

dev.copy(png,"plot2.png")
dev.off()


