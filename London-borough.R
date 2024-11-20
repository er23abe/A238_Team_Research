
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")

#head(dataset,2)

ds1 <- subset(dataset, Inner..Outer.London != "") # gets rid of blank rows and summary rows.

ds2 <- ds1[c('Area.name','Inner..Outer.London','Population.density..per.hectare..2016','Median.House.Price..2014')]
# isolates the 4 columns we're interested in. # using https://www.statology.org/r-select-specific-columns/

names(ds2)[1] <- "Borough"
names(ds2)[2] <- "Location"
names(ds2)[3] <- "Pop_Density"
names(ds2)[4] <- "Avg_House_Price"

ds2$Pop_Density <- as.numeric(ds2$Pop_Density) # using https://www.statology.org/character-to-numeric-in-r/
ds2$Avg_House_Price <- as.numeric(gsub(",", "", ds2$Avg_House_Price, fixed = TRUE)) # using https://data-hacks.com/convert-numbers-comma-separator-numeric-r

# below using https://herts.instructure.com/courses/116567/files/9935080?module_item_id=4380364 (Practical 3 intro to R).
h <- hist(ds2$Pop_Density, breaks = 10, xlab = "Population Density (People per Hectare)", ylab = "Frequency", main = "Histogram of Population Density")
x <- seq(min(ds2$Pop_Density), max(ds2$Pop_Density), length = 100)
y <- dnorm(x, mean = mean(ds2$Pop_Density), sd = sd(ds2$Pop_Density)) * length(ds2$Pop_Density)
box.size <- diff(h$mids[1:2])
y <- y * box.size
lines(x, y, col = "red") # in hist(), 'breaks' = number of bars in graph
h <- hist(ds2$Avg_House_Price, breaks = 10, xlab = "Median House Price (£)", ylab = "Frequency", main = "Histogram of Median House Price")
x <- seq(min(ds2$Avg_House_Price), max(ds2$Avg_House_Price), length = 100)
y <- dnorm(x, mean = mean(ds2$Avg_House_Price), sd = sd(ds2$Avg_House_Price)) * length(ds2$Avg_House_Price)
box.size <- diff(h$mids[1:2])
y <- y * box.size
lines(x, y, col = "red")
