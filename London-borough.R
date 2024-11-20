
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")

head(dataset,2)

ds1 <- subset(dataset, Inner..Outer.London != "") # gets rid of blank rows and summary rows.

ds2 <- ds1[c('Area.name','Inner..Outer.London','Population.density..per.hectare..2016','Median.House.Price..2014')]
# isolates the 4 columns we're interested in.
