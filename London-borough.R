
dataset <- read.csv("london-borough-profiles-2016 Data set.csv")

colnames(dataset)

filtered_london_Borough <- dataset[c("Area.name", "Median.House.Price..2014","Population.density..per.hectare..2016" )]

filtered_london_Borough_clean <- subset(filtered_london_Borough, !Area.name %in% c("","Inner London", "Outer London", "London", "England", "United Kingdom", "National comparator"))
