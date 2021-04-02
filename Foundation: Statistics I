#Statistics I: χ2 contingency analysis, simple t-test, linear regression and one-way ANOVA

rm(list = ls())

file.choose()
ladybird <- read.csv("file path")
library(dplyr)
library(ggplot2)
glimpse(ladybird)

## Rows: 20
## Columns: 4
## $ Habitat      <chr> "Rural", "Rural", "Rural", "Rural", "Rural", "Rural", "Ru…
## $ Site         <chr> "R1", "R2", "R3", "R4", "R5", "R1", "R2", "R3", "R4", "R5…
## $ morph_colour <chr> "black", "black", "black", "black", "black", "red", "red"…
## $ number       <int> 10, 3, 4, 7, 6, 15, 18, 9, 12, 16, 32, 25, 25, 17, 16, 17…

#χ2 contingency analysis
#demo data: ladybird morphology in rural and industrail areas, by Phil Warren
#"liuchen37/R_tutorials/ladybirds_morph_colour.csv"
#H0: no association between bird colours and their habitats

#Summarise observations in each group of colour
totals <- ladybird %>%
  group_by(Habitat, morph_colour) %>%
  summarise(total.observation = sum(number))
ggplot(totals, aes(x = Habitat, y = total.observation, fill = morph_colour)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  scale_fill_manual(values = c(black = "black", red = "red")) #position = 'dodge' means put two habitats seperated, rather than in one bar
ggsave("LadybirdTotal.png")

totals

## # A tibble: 4 x 3
## # Groups:   Habitat [2]
##   Habitat    morph_colour total.observation
##   <chr>      <chr>                    <int>
## 1 Industrial black                      115
## 2 Industrial red                         85
## 3 Rural      black                       30
## 4 Rural      red                         70

#Perfoming the χ2 test
#Constract a matrix consisting of habitat and colour
lady.mat <- xtabs(number ~ Habitat + morph_colour, data = ladybird)
lady.mat

##              morph_colour
##    Habitat    black red
##   Industrial   115  85
##   Rural         30  70

#χ2 test
chisq.test(lady.mat)

## Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  lady.mat
## X-squared = 19.103, df = 1, p-value = 1.239e-05

#p<0.001, H0 rejected

#Two-sample t-test
#demo data: ozone levels in several gardens, inspired by Crawley (2012)
#"liuchen37/R_tutorials/GardenOzone.csv"

rm(list = ls())

file.choose()
ozone <- read.csv("file path")
glimpse(ozone)
ggplot(ozone, aes(x = Ozone)) +
  geom_histogram(binwidth = 10) +
  facet_wrap(~ Garden.location, ncol = 1) +
  theme_bw()
ggsave("5.2.png")

#Calculate mean ozone in W/E gardens (/)
ozone %>%
  group_by(Garden.location) %>%
  summarise(meanozone = mean(Ozone))
  
## # A tibble: 2 x 2
##   Garden.location meanozone
##   <chr>               <dbl>
## 1 East                 77.3
## 2 West                 61.3

#t-test
t.test(Ozone ~ Garden.location, data = ozone)

## 	Welch Two Sample t-test
## 
## data:  Ozone by Garden.location
## t = 4.2363, df = 17.656, p-value = 0.0005159
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##   8.094171 24.065829
## sample estimates:
## mean in group East mean in group West 
##              77.34              61.26 

#p<0.001
