
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")

head(dataset,2)

ds1 <- subset(dataset, Inner..Outer.London != "") # gets rid of blank rows and summary rows.

ds2 <- ds1[c('Area.name','Inner..Outer.London','Population.density..per.hectare..2016','Median.House.Price..2014')]
# isolates the 4 columns we're interested in. # using https://www.statology.org/r-select-specific-columns/

names(ds2)[1] <- "Borough"
names(ds2)[2] <- "Location"
names(ds2)[3] <- "Pop_Density"
names(ds2)[4] <- "Avg_House_Price"



