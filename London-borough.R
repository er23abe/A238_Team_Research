#installing packages
library(readr)
install.packages("tidyverse")

#importing dataset into r
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")

colnames(dataset)

#Filtering to create a new df with only the three columns we are interested in.
filtered_london_Borough <- dataset[c("Area.name", "Median.House.Price..2014", "Population.density..per.hectare..2016" )]

#Cleaning or data by creating a new df with no missing values
filtered_london_Borough_clean <- subset(filtered_london_Borough, !Area.name %in% c("","Inner London", "Outer London", "London", "England", "United Kingdom", "National comparator"))

#Further clean of data by removing commas from price e.g. 750,000 -> 750000
filtered_london_Borough_clean$Median.House.Price..2014 <- 
  gsub(",", "", filtered_london_Borough_clean$Median.House.Price..2014)

#Change character data type to numeric data type
filtered_london_Borough_clean$Median.House.Price..2014 <- as.numeric(filtered_london_Borough_clean$Median.House.Price..2014)
filtered_london_Borough_clean$Population.density..per.hectare..2016 <- as.numeric(filtered_london_Borough_clean$Population.density..per.hectare..2016)

head(filtered_london_Borough_clean,2)

###########Visualization##########

#Histogram and Box plot for dependent variable median house price
h <-hist(filtered_london_Borough_clean$Median.House.Price..2014, breaks = 10, xlab = "Median House Price (£)", ylab = "Frequency", main =
           "Histogram of Median House Prices by London Borough (2014)")
boxplot(filtered_london_Borough_clean$Median.House.Price..2014, ylab="Median House Price (£)", main="Box Plot of Median House Prices by London Borough (2014)", horizontal = TRUE)

x <- seq(min(filtered_london_Borough_clean$Median.House.Price..2014), max(filtered_london_Borough_clean$Median.House.Price..2014), length= 40)
y <- dnorm(x, mean=mean(filtered_london_Borough_clean$Median.House.Price..2014), sd=sd(filtered_london_Borough_clean$Median.House.Price..2014))
y <- y * diff(h$mid[1:2]) * length(filtered_london_Borough_clean$Median.House.Price..2014)
lines(x,y,col="red")



#Histogram and Box plot for independent variable population density
h <-hist(filtered_london_Borough_clean$Population.density..per.hectare..2016, breaks = 10, xlab = "Frequency", ylab = "Population Density (per hectare)", main =
           "Histogram of Population Density (per hectare) in London BoroughS (2016)")
boxplot(filtered_london_Borough_clean$Population.density..per.hectare..2016)


#As our data is not normal we are going to use spearmans correlation
cor.test(filtered_london_Borough_clean$Population.density..per.hectare..2016, 
         filtered_london_Borough_clean$Median.House.Price..2014, method="spearman")

#Plotting a scatter graph
plot(filtered_london_Borough_clean$Population.density..per.hectare..2016, filtered_london_Borough_clean$Median.House.Price..2014, xlab="Population Density (per hectare)", ylab="Median House Price (£)", main="Scatterplot of Population Density vs Median House Price")

#Line on the scatter plot
abline(lm(filtered_london_Borough_clean$Median.House.Price..2014 ~ filtered_london_Borough_clean$Population.density..per.hectare..2016), col ="red")

         