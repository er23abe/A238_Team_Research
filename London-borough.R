
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")

head(dataset,2)

ds1 <- subset(dataset, Inner..Outer.London != "") # gets rid of blank rows and summary rows.

#ds <- subset(dataset$Area.name, dataset$Inner..Outer.London, dataset$Population.density..per.hectare..2016, dataset$Median.House.Price..2014)
# ^^^ subset gets rid of rows, we need to specify the 4 columns from the powerpoint screenshot - name inner/pouter, median price, pop density. 
