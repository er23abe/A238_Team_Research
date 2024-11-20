
#load the dataset
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")
###head(dataset,2)
#remove blank rows and summary rows
ds1 <- subset(dataset, Inner..Outer.London != "") 
# isolate the 4 columns we're interested in. # using https://www.statology.org/r-select-specific-columns/
ds2 <- ds1[c('Area.name','Inner..Outer.London','Population.density..per.hectare..2016','Median.House.Price..2014')]
# rename columns to be shorter and easier to use
names(ds2)[1] <- "Borough"
names(ds2)[2] <- "Location"
names(ds2)[3] <- "Pop_Density"
names(ds2)[4] <- "Avg_House_Price"

# convert character datatype to numeric
ds2$Pop_Density <- as.numeric(ds2$Pop_Density) # using https://www.statology.org/character-to-numeric-in-r/
ds2$Avg_House_Price <- as.numeric(gsub(",", "", ds2$Avg_House_Price, fixed = TRUE)) # using https://data-hacks.com/convert-numbers-comma-separator-numeric-r

# create histograms of the population density and median house prices
# below using https://herts.instructure.com/courses/116567/files/9935080?module_item_id=4380364 (Practical 3 intro to R).
h <- hist(ds2$Pop_Density, breaks = 10, xlab = "Population Density (People per Hectare)", ylab = "Frequency", main = "Histogram of Population Density")
x <- seq(min(ds2$Pop_Density), max(ds2$Pop_Density), length = 100)
y <- dnorm(x, mean = mean(ds2$Pop_Density), sd = sd(ds2$Pop_Density)) * length(ds2$Pop_Density)
box.size <- diff(h$mids[1:2])
y <- y * box.size
lines(x, y, col = "red") 
h <- hist(ds2$Avg_House_Price, breaks = 10, xlab = "Median House Price (£)", ylab = "Frequency", main = "Histogram of Median House Price")
x <- seq(min(ds2$Avg_House_Price), max(ds2$Avg_House_Price), length = 100)
y <- dnorm(x, mean = mean(ds2$Avg_House_Price), sd = sd(ds2$Avg_House_Price)) * length(ds2$Avg_House_Price)
box.size <- diff(h$mids[1:2])
y <- y * box.size
lines(x, y, col = "red")
# in hist(), 'breaks' = number of bars in graph
# frequency (y axis) represents the number of boroughs with that x value / range of x values

# perform statistical analysis
t.test(ds2$Pop_Density ~ ds2$Location) # for normal data. Has to be Location because otherwise get an error saying "grouping factor must have exactly 2 levels"
# 	Welch Two Sample t-test
# data:  ds2$Pop_Density by ds2$Location
# t = 6.7815, df = 17.321, p-value = 2.902e-06
# alternative hypothesis: true difference in means between group Inner London and group Outer London is not equal to 0
# 95 percent confidence interval:
#  42.56847 80.93905
# sample estimates:
# mean in group Inner London mean in group Outer London 
#                  109.16429                   47.41053 
## a test to see whether the means between the two populations (inner/outer London) are equal. 
## in this case, they are not.
wilcox.test(ds2$Pop_Density ~ ds2$Location) # for non-parametric data. Has to be Location because otherwise get an error saying "grouping factor must have exactly 2 levels"
# Wilcoxon rank sum exact test
# data:  ds2$Pop_Density by ds2$Location
# W = 250, p-value = 2.228e-06
# alternative hypothesis: true location shift is not equal to 0
## a test to see if "for randomly selected values X and Y from two populations, the probability of X being greater than Y is equal to the probability of Y being greater than X."
t.test(ds2$Avg_House_Price ~ ds2$Location) # for normal data. Has to be Location because otherwise get an error saying "grouping factor must have exactly 2 levels"
# Welch Two Sample t-test
# data:  ds2$Avg_House_Price by ds2$Location
# t = 3.2914, df = 14.613, p-value = 0.005095
# alternative hypothesis: true difference in means between group Inner London and group Outer London is not equal to 0
# 95 percent confidence interval:
#   80673.84 379117.14
# sample estimates:
#   mean in group Inner London mean in group Outer London 
# 561392.9                   331497.4 
## a test to see whether the means between the two populations (inner/outer London) are equal. 
## in this case, they are not.
wilcox.test(ds2$Avg_House_Price ~ ds2$Location) # for non-parametric data. Has to be Location because otherwise get an error saying "grouping factor must have exactly 2 levels"
# Wilcoxon rank sum test with continuity correction
# data:  ds2$Avg_House_Price by ds2$Location
# W = 226, p-value = 0.0007457
# alternative hypothesis: true location shift is not equal to 0
## a test to see if "for randomly selected values X and Y from two populations, the probability of X being greater than Y is equal to the probability of Y being greater than X."

# comment multiple lines at once by highlighting text, then ctrl + shift + C. using https://www.statology.org/r-multiline-comment/
# info on tests using https://en.wikipedia.org/wiki/Welch's_t-test
# correlation test
cor.test(ds2$Pop_Density, ds2$Avg_House_Price)
# Pearson's product-moment correlation
# data:  ds2$Pop_Density and ds2$Avg_House_Price
# t = 2.7578, df = 31, p-value = 0.009668
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.1186246 0.6830788
# sample estimates:
#       cor 
# 0.4438576 
cor.test(ds2$Pop_Density, ds2$Avg_House_Price, method="spearman")
# Spearman's rank correlation rho
# data:  ds2$Pop_Density and ds2$Avg_House_Price
# S = 2998.5, p-value = 0.003122
# alternative hypothesis: true rho is not equal to 0
# sample estimates:
#      rho 
# 0.498913

## for all above tests, the p value was less than 0.05 so we can reject the null hypothesis that the median house prices and population densities are consistent between inner and outer London

# plotting a scatter graph of population density against median house price
plot(ds2$Pop_Density, ds2$Avg_House_Price, xlab = "Population Density (People per Hectare)", ylab = "Median House Price (£)", main = "Scatterplot of Population Density vs Median House Price")
abline(lm(Avg_House_Price ~ Pop_Density, data = ds2), col = "red") # Add a trend line





